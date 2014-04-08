<?php


class Dept_Model extends TZ_Model {
    
    public $_tableName = 'tb_dept';
    public $_deptTree = array() ;
    
    public function __construct(){
        parent::__construct();
    }
    
    
    
    /**
     * 获得部门
     * @param type $parentId
     * @param type $selfId
     * @param type $separate
     * @return type 
     */
    public function getDeptListByTree($parentId = 0,$selfId = 0,$separate = '',$level = 0) {
        $childrenList = $this->geDeptList($parentId,$selfId);
        if(is_array($childrenList)){
            foreach ($childrenList as $item){
                $item['title'] = $separate . $item['name'];
                $item['level'] = $level;
                
                $this->_deptTree[] = $item;
                
                $this->getDeptListByTree($item['id'],$selfId,$separate . '&nbsp;&nbsp;',$level + 1);
            }
        }
		
		return $this->_deptTree;
	}



	public function geDeptList($parentId = 0,$selfId = 0) {
		
        $parentId = $parentId < 0 ? 0 : $parentId;
        $selfId   = $selfId < 0 ? 0 : $selfId;
        $condition = array(
          'where' => array(
              'status' => '正常',
              'pid' => $parentId,
              'id !=' => $selfId
          ),
          'order' => 'pid ASC'
        );
        
        $result = $this->getList($condition);
		
		return $result['data'];
	}
    
    
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
        
        $where = array(
            'id' => $param['id']
        );
        
        $data = array(
            'status' => '已删除'
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($param){
        $data = array(
            'name' => $param['name'],
            'pid' => $param['pid'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
}