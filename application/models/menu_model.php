<?php


class Menu_Model extends TZ_Model {
    
    public $_tableName = 'tb_menu';
    public $_menuTree = array() ;
    public $_fullTree = array();
    
    public function __construct(){
        parent::__construct();
    }
    
    public function saveTree($tree){
        $this->_fullTree = $tree;
    }
    
    public function clearMenuTree(){
        $this->_menuTree = array();
    }
    
    
    public function getListByTree($parentId = 0,$selfid = 0,$separate = '----',$level = 0) {
        
        $parentId = $parentId < 0 ? 0 : intval($parentId);
        //$selfId   = $selfId < 0 ? 0 : intval($selfId);
        $condition = array(
          'where' => array(
              'status' => '正常',
              'pid' => $parentId,
          ),
          'order' => 'displayorder DESC,pid ASC'
        );
        
        if(is_array($selfid)){
            $condition['where_not_in'] = array(
                array('key' => 'id' ,'value' => $selfid)
                );
        }else{
            $condition['where']['id !='] =  $selfid;
        }
        
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
                
                $this->_menuTree[$item['id']] = $item;
                
                $this->getListByTree($item['id'],$selfid, $separate,$level + 1);
            }
        }
		
		return $this->_menuTree;
	}
    

    public function add($param){
        $now = time();
        $data = array(
            'id' => NULL,
            'auth_key' => md5($param['url']),
            'url' => $param['url'],
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