<?php


class File_Model extends TZ_Model {
    
    public $_tableName = 'tb_files';
    
    public $_dirTree = array();
    public $_parentList = array();
    
    public function __construct(){
        parent::__construct();
    }
    
    
    public function add($data){
        
        $string = $this->db->insert_string($this->_tableName, $data);
        $query = $this->db->query($string);
        
        if($this->db->affected_rows()){
            return $this->db->insert_id();
        }else{
            return false;
        }
    }
    
    
    /**
     * 获得祖先列表
     * @param type $selfid 
     */
    public function getParents($selfid = 0){
        
        $condition['select'] = 'id,pid,file_name';
        $condition['where'] = array(
            'status' => 0,
            'id' => $selfid
        );
        
        $result = $this->getById($condition);
        if($result){
            $this->_parentList[] = $result;
            $this->getParents($result['pid']);
        }
        
        return $this->_parentList;
    }
    
    public function getListByTree($parentId = 0,$selfid = 0,$isdir = 1,$user_id = 0,$separate = '----',$level = 0) {
        $parentId = $parentId < 0 ? 0 : intval($parentId);
        $condition = array(
          'where' => array(
              'status' => 0,
              'pid' => $parentId,
              'user_id' => $user_id,
              'is_dir' => $isdir
          ),
          'order' => 'pid ASC'
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
                
                $this->_dirTree[$item['id']] = $item;
                
                $this->getListByTree($item['id'],$selfid,$isdir,$user_id,$separate,$level + 1);
            }
        }
		
		return $this->_dirTree;
	}
    
    /**
     * really delete
     * @param type $user 
     */
    public function delete($param){
        
    }
    
    
    public function fake_delete($param){
        
        $where = array(
            'id' => $param['id'],
        );
        
        if($param['is_dir']){
            $where['is_dir'] = $param['is_dir'];
        }
        
        $data = array(
            'status' => '1'
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
    public function update($param){
        $data = array(
            'file_name' => $param['file_name'],
            'updator' => $param['updator'],
            'updatetime' => time()
        );
        
        $where = array(
            'id' => $param['id']
        );
        
        return $this->db->update($this->_tableName, $data, $where);
    }
    
    
}