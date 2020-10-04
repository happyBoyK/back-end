/**
 * 自动生成代码：service模版
 * 2018年1月17日 
 */
const fs = require('fs');
const common = require('../util/common.js');
const _path='/front-end/src/views';

module.exports =  {
  do(time,param,data) {
  	/*
  	创建目录
  	 */
  	let targetDir=think.config('generator_path')+'/'+time+_path+'/'+param.mokuainame;
  	common.mkdirs(targetDir);
  	let file=targetDir+'/'+param.tablename+'.vue';
  	let template=
  	"<style lang=\"less\">\r\n"+
      "     .table-min-width{\r\n"+
      "        min-width:120px;\r\n"+
      "        width:120px\r\n"+
      "    }\r\n"+
      "</style>\r\n"+
      "<template>\r\n"+
      "     <div>\r\n"+    
      "        <Row>\r\n"+
      "            <Col span=\"24\">\r\n"+
      "                <Card>\r\n"+
      "                    <p slot=\"title\">\r\n"+
      "                        <Icon type=\"ios-list\"></Icon>\r\n"+
      "                        "+param.tablecomment+"列表\r\n"+
      "                    </p>\r\n"+
      "                    <Row>\r\n";
      for(let p of param.parameter){
        if(p.is_search==1){
      template+=
      "                        "+p.comment+"：<Input v-model=\"searchForm."+p.name+"\" placeholder=\"请输入要搜索的"+p.comment+"\" style=\"width: 200px;margin-right: 20px;\" />\r\n";
        }
      }    
      template+=
      "                        <span @click=\"handleSearch\"><Button type=\"primary\" icon=\"search\">搜索</Button></span>\r\n"+
      "                    </Row>\r\n"+
      "                    <Row style=\"margin-top:10px;\">\r\n"+
      "                        <Button type=\"info\" @click=\"add\">添加</Button>\r\n"+
      "                    </Row>\r\n"+
      "                    <Row type=\"flex\" justify=\"center\" align=\"middle\" class=\"advanced-router\">\r\n"+
      "                        <Table border stripe :columns=\"columns\" :data=\"data\" :loading=\"loading\" style=\"width: 100%;margin-top:10px\"></Table>\r\n"+
      "                        <Page :total=\"count\" :current=\"searchForm.current\" show-total  style=\"margin-top:10px;\" @on-change=\"pageChange\"></Page>\r\n"+
      "                    </Row>\r\n"+
      "                </Card>\r\n"+
      "            </Col>\r\n"+
      "        </Row>\r\n"+
      "        <Modal  title=\"编辑\"  :mask-closable=\"false\" :closable=\"false\" v-model=\"modalAdd\">\r\n"+
      "            <Form ref=\"formRef\" :model=\"formValidate\" :rules=\"ruleValidate\" :label-width=\"80\">\r\n";
      for(let p of param.parameter){
        if(p.name!='id'&&p.name!='create_date'&&p.name!='update_date'&&p.name!='del_flag'){
      template+=
      "                <FormItem label=\""+p.comment+"\" prop=\""+p.name+"\">\r\n"+
      "                    <Input v-model=\"formValidate."+p.name+"\"></Input>\r\n"+
      "                </FormItem>\r\n";    
        }   
      }   
      template+=                
      "            </Form>\r\n"+
      "            <div slot=\"footer\">\r\n"+
      "                <Button type=\"text\" @click=\"addCanFun\" v-show=\"modalCanBut\">取消</Button>\r\n"+
      "                <Button type=\"primary\" @click=\"addOkFun\" :loading=\"modalLoading\">确定</Button>\r\n"+
      "            </div>\r\n"+
      "        </Modal>    \r\n"+
       "        <Modal  title=\"详情\" v-model=\"modalDetail\">\r\n"+
      "            <Form :model=\"formValidate\" :label-width=\"80\">\r\n";
      for(let p of param.parameter){
        if(p.name!='id'&&p.name!='create_date'&&p.name!='update_date'&&p.name!='del_flag'){
      template+=
      "                <FormItem label=\""+p.comment+"\">\r\n"+
      "                    <Input v-model=\"formValidate."+p.name+"\" readonly></Input>\r\n"+
      "                </FormItem>\r\n";    
        }   
      }   
      template+=                
      "            </Form>\r\n"+
      "            <div slot=\"footer\">\r\n"+
      "            </div>\r\n"+
      "        </Modal>    \r\n"+
      "    </div>\r\n"+
      "</template>\r\n"+
      "<script>\r\n"+
      "    import util from '@/libs/util.js';\r\n"+
      "    export default {\r\n"+
      "        data () {\r\n"+
      "            return {\r\n"+
      "                modalAdd:false,\r\n"+
      "                modalDetail:false,\r\n"+
      "                loading:false,\r\n"+
      "                modalLoading:false,\r\n"+
      "                modalCanBut:true,\r\n"+
      "                searchForm:{\r\n"+
      "                    current:1\r\n"+
      "                },\r\n"+
      "                data: [],\r\n"+
      "                formValidate: {\r\n"+
      "                },\r\n"+
      "                count:0,\r\n"+
      "                columns: [     \r\n"; 
      for(let p of param.parameter){
        if(p.is_show==1){
      template+=
      "                    {\r\n"+
      "                        title: '"+p.comment+"',\r\n"+
      "                        key: '"+p.name+"',\r\n"+
      "                        className: 'table-min-width',\r\n"+
      "                        ellipsis:true,\r\n"+
      "                        align: 'center',\r\n"+
      "                    },\r\n";
        }   
      }   
      template+=                
      "                    {\r\n"+
      "                        title: '操作',\r\n"+
      "                        key: 'action',\r\n"+
      "                        width: 210,\r\n"+
      "                        align: 'center',\r\n"+
      "                        render: (h, params) => {\r\n"+
      "                            return h('div', [\r\n"+   
      "                                h('Button', {\r\n"+
      "                                    props: {\r\n"+
      "                                        type: 'info',\r\n"+
      "                                        size: 'small'\r\n"+
      "                                    },\r\n"+
      "                                    style: {\r\n"+
      "                                        marginRight: '5px'\r\n"+
      "                                    },\r\n"+
      "                                    on: {\r\n"+
      "                                        click: () => {\r\n"+
      "                                            this.show(params)\r\n"+
      "                                        }\r\n"+
      "                                    }\r\n"+
      "                                }, '查看'),\r\n"+                          
      "                                h('Button', {\r\n"+
      "                                    props: {\r\n"+
      "                                        type: 'success',\r\n"+
      "                                        size: 'small'\r\n"+
      "                                    },\r\n"+
      "                                    style: {\r\n"+
      "                                        marginRight: '5px'\r\n"+
      "                                    },\r\n"+
      "                                    on: {\r\n"+
      "                                        click: () => {\r\n"+
      "                                            this.edit(params)\r\n"+
      "                                        }\r\n"+
      "                                    }\r\n"+
      "                                }, '编辑'),\r\n"+
      "                                h('Poptip', {\r\n"+
      "                                    props: {\r\n"+
      "                                        confirm: true,\r\n"+
      "                                        title: '您确定要删除这条数据吗?',\r\n"+
      "                                        transfer: true\r\n"+
      "                                    },\r\n"+
      "                                    on: {\r\n"+
      "                                        'on-ok': () => {\r\n"+
      "                                           this.remove(params);\r\n"+
      "                                        }\r\n"+
      "                                    }\r\n"+
      "                                }, [\r\n"+
      "                                    h('Button', {\r\n"+
      "                                        style: {\r\n"+
      "                                            marginRight: '5px'\r\n"+
      "                                        },\r\n"+
      "                                        props: {\r\n"+
      "                                            type: 'error',\r\n"+
      "                                            placement: 'top',\r\n"+
      "                                            size: 'small'\r\n"+
      "                                        }\r\n"+
      "                                    }, '删除')\r\n"+
      "                                ])\r\n"+
      "                            ]);\r\n"+
      "                        }\r\n"+
      "                    }\r\n"+
      "                ],\r\n"+
      "                ruleValidate: {\r\n"; 
      for(let p of param.parameter){
        if(p.name!='id'&&p.name!='create_date'&&p.name!='update_date'&&p.name!='del_flag'){
      template+=
      "                    "+p.name+": [\r\n"+
      "                        { required: true, message: '"+p.comment+"为必填项'}\r\n"+
      "                    ],\r\n";
        }   
      }   
      template+=                                          
      "                }\r\n"+
      "            }\r\n"+
      "        },\r\n"+
      "        methods: {\r\n"+
      "            init () {\r\n"+
      "                let _self=this;\r\n"+
      "                _self.loading=true;\r\n"+
      "                util.post(this,'"+param.mokuainame+"/"+param.tablename+"/pageData',this.searchForm,function(datas){   \r\n"+               
      "                    _self.data=datas.data;\r\n"+
      "                    _self.count=datas.count;\r\n"+
      "                    _self.loading=false;\r\n"+                
      "                });\r\n"+
      "            },\r\n"+
      "            handleSearch(){\r\n"+
      "                this.searchForm.current=1;\r\n"+
      "                this.init();\r\n"+
      "            },\r\n"+
      "            pageChange(current){\r\n"+
      "                this.searchForm.current=current;\r\n"+
      "                this.init();\r\n"+
      "            },\r\n"+
      "            add (){     \r\n"  +
      "                this.formValidate={}; \r\n"+           
      "                this.modalAdd=true;       \r\n"  +   
      "            },\r\n"+
      "            show (param) {\r\n"+
      "                this.formValidate=util.copy(param.row);\r\n"+
      "                this.modalDetail=true;        \r\n "  +               
      "            },\r\n"+
      "            edit (param) {\r\n"+
      "                this.formValidate=util.copy(param.row);\r\n"+
      "                this.modalAdd=true;        \r\n "  +               
      "            },\r\n"+
      "            remove (param) {\r\n"+
      "                let _self=this;\r\n"+
      "                this.loading=true;\r\n"+
      "                util.post(this,'"+param.mokuainame+"/"+param.tablename+"/delData',{id:param.row.id},function(datas){ \r\n"+
      "                    _self.data.splice(param.index, 1);\r\n"+
      "                    _self.loading =false;      \r\n"  +       
      "                    _self.$Message.success('删除成功！');\r\n"  +           
      "                });\r\n"+
      "            },\r\n"+
      "            addOkFun(){\r\n"+
      "                let _self=this;\r\n"+
      "                this.$refs['formRef'].validate((valid) => {\r\n"+
      "                    if (valid) {\r\n"+
      "                        util.changeModalLoading(this,true);\r\n"+
      "                        let _data=util.copy(this.formValidate); \r\n"+    
      "                        if(this.formValidate&&this.formValidate.id){\r\n"+
      "                            util.post(this,'"+param.mokuainame+"/"+param.tablename+"/updateData',_data,function(datas){  \r\n"  +              
      "                                _self.$Message.success('编辑成功！');\r\n"+
      "                                _self.addCanFun();\r\n"  +
      "                                _self.init();      \r\n"  +
      "                            });                        \r\n"  +
      "                        }else{\r\n"+
      "                            util.post(this,'"+param.mokuainame+"/"+param.tablename+"/addData',_data,function(datas){ \r\n"  +               
      "                                _self.$Message.success('新增成功！');\r\n"+
      "                                _self.addCanFun(); \r\n"+
      "                                _self.init();     \r\n"  +         
      "                            });     \r\n"  +                   
      "                        }\r\n"+                              
      "                    }else{\r\n"+
      "                        util.changeModalLoading(this);\r\n"+
      "                    } \r\n"+
      "                })  \r\n"  +        
      "            },   \r\n"  +    
      "            addCanFun(){ \r\n"+     
      "                this.modalAdd=false; \r\n"+
      "                util.changeModalLoading(this);\r\n"  +       
      "                this.$refs['formRef'].resetFields(); \r\n"+
      "            }\r\n"+
      "        },\r\n"+
      "        mounted () {\r\n"+
      "            this.init();\r\n"+
      "        }\r\n"+
      "    }\r\n"+
      "</script>";
  	fs.writeFileSync(file,template);
  }
};
