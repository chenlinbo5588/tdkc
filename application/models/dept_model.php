<?php


class Dept_Model extends TZ_Model {
    
    public $_tableName = 'tb_dept';
    public $_deptTree = array() ;
    public $_fullTree = array();
    
    public function __construct(){
        parent::__construct();
    }
    
    public function saveTree($tree){
        $this->_fullTree = $tree;
    }
    
    public function clearDeptTree(){
        $this->_deptTree = array();
    }
    
    /**
     * 获得部门
     * @param type $parentId
     * @param type $selfId
     * @param type $separate
     * @return type 
     */
    public function getDeptListByTree($parentId = 0,$separate = '----',$level = 0) {
        
        $parentId = $parentId < 0 ? 0 : intval($parentId);
        //$selfId   = $selfId < 0 ? 0 : intval($selfId);
        $condition = array(
          'where' => array(
              'status' => '正常',
              'pid' => $parentId,
          ),
          'order' => 'pid ASC'
        );
        
        $result = $this->getList($condition);
        $childrenList = $result['data'];
        if(is_array($childrenList)){
            foreach ($childrenList as $item){
                
                $sepA = array();
                for($i = 0; $i < $level; $i++){
                    $sepA[] = $separate;
                }
                $item['sep'] = implode('',$sepA);
                
                $item['level'] = $level;
                
                $this->_deptTree[$item['id']] = $item;
                
                $this->getDeptListByTree($item['id'],$separate,$level + 1);
            }
        }
		
		return $this->_deptTree;
	}
    
    /*
    public function getChildsDeptList($parentId = 0,$separate,$level){
        $condition = array(
          'where' => array(
              'status' => '正常',
              'pid' => $parentId,
          ),
          'order' => 'pid ASC'
        );
        $result = $this->getList($condition);
        $childrenList = $result['data'];
        if(is_array($childrenList)){
            foreach ($childrenList as $item){
                $item['title'] = $separate . $item['name'];
                $item['level'] = $level;
                
                $this->_deptTree[$item['id']] = $item;
                
                $this->getDeptListByTree($item['id'],$separate . '&nbsp;&nbsp;',$level + 1);
            }
        }
        
    }
     * 
     */

    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'name' => $param['name'],
            'pid' => $param['pid'],
            'creator' => $param['creator'],
            'updator' => $param['updator'],
            'createtime' => $now,
            'updatetime' => $now
        );
        
        return $this->db->insert($this->_tableName, $data);
    }
    
    public function delete($param){
        
    }
    
    public function fake_delete($param){
        
        if(is_array($param['id'])){
             $data = array();
           
            foreach($param['id'] as $v){
                $data[] = array(
                    'id' => $v,
                    'status' => '已删除'
                );
            }
            
            return $this->db->update_batch($this->_tableName, $data,'id'); 
        }else{
            $data = array(
                'status' => '已删除'
            );
            
            $where = array(
                'id' => $param['id']
            );
            return $this->db->update($this->_tableName, $data,$where);
        }
        
    }
    
    
    public function update($param){
        $data = array(
            'name' => $param['name'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        if(!empty($param['pid'])){
            $data['pid'] = $param['pid'];
        }
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
}