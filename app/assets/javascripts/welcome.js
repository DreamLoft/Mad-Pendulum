var url= "http://ec2-35-154-49-51.ap-south-1.compute.amazonaws.com/api/data";
dataRequest(url);
function dataRequest(url){
  d3.json(url, function (err, data) {
            if (err){

            }else {
                      dashboard(data);
            }
  });
}

//------------------------Dashboard Function :- Container for all Dashboard components----------------

function dashboard(data) {

          //------------------------------------------------colors Array to use for Bar Graph

          var COLOR = d3.scale.category20();

          // -----------------------------------------------data extraction variables from http endpoint
          var projects,tasks,users,timesheets;
          var dataMap= d3.map(data);
          //------------------------------------------------------Function to extract Projects from Raw Data
          function getProjects(d) {
                    return d.get("projects");
          }
          //------------------------------------------------------Function to extract Tasks from Raw Data
          function getTasks(d) {
                   return d.get("tasks");
          }
          //-------------------------------------------------------Function to extract Users for Raw Data
          function getUsers(d) {
                  return  d.get("users");
          }

          //------------------------------------------------------------Function to extract Timesheets from Raw Data
          function getTimesheets(d) {
                    return d.get("timesheets");
          }


          //------------------------------------------------------------------ Data Assignment to variables
          projects= getProjects(dataMap);
          tasks= getTasks(dataMap);
          users= getUsers(dataMap);
          timesheets= getTimesheets(dataMap);

          //----------------------------------------------------Dummy data for default projects for Bar-Garph
          var myprojects = [];
          function projectsArray() {
                    myprojects=  projects.map(function (p) {
                              return p.id;
                    }).slice(-10);
//                    console.log(myprojects);
          }
          projectsArray();
          //------------------------------------------------------------------------------------------Project Histogram function call for Rendering Bar garph
          var projectHistoGram =projectHistogram(myprojects);

          //------------------------------------------------------------------function call to Populate Projects in Selection 10 Projects for selection
          projectSelectionPopulate();


          //-----------------------------------------------------------------Function to get information about a Project , Task or User by id attribute
          function getProjectById(pid) {
                              var result =projects.filter(function( obj ) {
                                        return obj.id == pid;
                              })[0] ;
                              return result;
                    }
          function getTaskById(tid) {
                    var result= tasks.filter(function (obj) {
                              return obj.id==tid;
                    })[0];
                    return result;
          }
          function getUserById(uid) {
                    var result= users.filter(function (obj) {
                              return obj.id==uid;
                    })[0];
                    return result;
          }

          //------------------------------------------------------------------------function to populate projects data in select 10 projects bars dynamically
          function projectSelectionPopulate() {
                  //  console.log(projects[0]);
                    var selector= document.getElementById("pselect");
                    for (p in projects){
                              var label=document.createElement('label');
                              label.textContent= projects[p].projectname;
                              label.className="list-group-item";
                              var checkbox= document.createElement('input');
                              checkbox.type='checkbox';
                              checkbox.name='projectcheckbox[]';
                              checkbox.value= projects[p].id;
                              label.appendChild(checkbox);
                              selector.appendChild(label);
                    }
          }

          //-------------------------------------------------------------------------Functions to Handle Filters for Projects Tab, Category and Designation tab
          function projectsFilter(cat,task,deg) {
                    //     console.log()
                    var mn = [];
                    var localtimesheets=[];
                    if (cat ==0 && deg == 0){
                              for (var count in myprojects) {
                                        localtimesheets = timesheets.filter(function (t) {
                                                  return t.project_id == parseInt(myprojects[count]);
                                        });
                                        var myd = d3.nest()
                                                  .key(function (d) {
                                                            return d.project_id;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localtimesheets);
                                        var ds = new Object();
                                        ds.key = myprojects[count];
                                        if (myd[0] == undefined) {
                                                  ds.values = 0
                                        } else {
                                                  ds.values = myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    } else if (cat !=0 && deg ==0){
                              for (var count in myprojects) {
                                        localtimesheets = timesheets.filter(function (t) {
                                                  return t.project_id == parseInt(myprojects[count]);
                                        });

                                        var catdata = localtimesheets.filter(function (t) {
                                                  if (task== 0) {
                                                            return getTaskById(t.task_id).task_category == cat;
                                                  }else if (task !=0){
                                                            return (getTaskById(t.task_id).task_category == cat) && (t.task_id ==task) ;
                                                  }
                                        });
                                        var myd = d3.nest()
                                                  .key(function (d) {
                                                            return d.project_id;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(catdata);
                                        var ds = new Object();
                                        ds.key = myprojects[count];
                                        if (myd[0] == undefined) {
                                                  ds.values = 0
                                        } else {
                                                  ds.values = myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }else if (cat==0 && deg != 0){
                              for (var count in myprojects) {
                                        localtimesheets = timesheets.filter(function (t) {
                                                  return t.project_id == parseInt(myprojects[count]);
                                        });

                                        var degdata = localtimesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == deg;
                                        });

                                        var myd = d3.nest()
                                                  .key(function (d) {
                                                            return d.project_id;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(degdata);
                                        var ds = new Object();
                                        ds.key = myprojects[count];
                                        if (myd[0] == undefined) {
                                                  ds.values = 0
                                        } else {
                                                  ds.values = myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }else if (cat !=0 && deg !=0){
                              for (var count in myprojects) {
                                        localtimesheets = timesheets.filter(function (t) {
                                                  return t.project_id == parseInt(myprojects[count]);
                                        });

                                        var catdata = localtimesheets.filter(function (t) {
                                                  if (task== 0) {
                                                            return (getTaskById(t.task_id).task_category == cat) && (getUserById(t.user_id).designation == deg) ;
                                                  }else if (task !=0){
                                                            return (getTaskById(t.task_id).task_category == cat) && (t.task_id ==task) && (getUserById(t.user_id).designation == deg) ;
                                                  }
                                        });
                                        var myd = d3.nest()
                                                  .key(function (d) {
                                                            return d.project_id;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(catdata);
                                        var ds = new Object();
                                        ds.key = myprojects[count];
                                        if (myd[0] == undefined) {
                                                  ds.values = 0
                                        } else {
                                                  ds.values = myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }
                    return mn;
          }
          function categoryFilter(pro,deg) {
                    var h= d3.nest()
                              .key(function(d) { return d.task_category; })
                              .entries(tasks)
                    var categories= h.map(function (t) {
                              return t.key;
                    });
                    var mn = [];
                    var localTsheets=[];
                    if (pro==0 && deg==0){
                              for (var c in categories) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == categories[c];
                                        });
                                        var ds= new Object();
                                        if (localTsheets.length<=0){
                                                  ds.key=categories[c];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localTsheets);
                                                  ds.key=categories[c];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                              return mn;
                    }else if (pro==0 && deg !=0){
                              for (var c in categories) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == categories[c];
                                        });
                                        var prodata = localTsheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == deg;
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=categories[c];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=categories[c];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                              return mn;
                    }else if (pro !=0 && deg==0){
                              for (var c in categories) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == categories[c];
                                        });
                                        var prodata = localTsheets.filter(function (t) {
                                                  return t.project_id == pro;
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=categories[c];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=categories[c];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                              return mn;
                    }else if (pro !=0 && deg !=0){
                              for (var c in categories) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == categories[c];
                                        });
                                        var prodata = localTsheets.filter(function (t) {
                                                  return (t.project_id == pro)&& (getUserById(t.user_id).designation== deg);
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=categories[c];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=categories[c];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                              return mn;
                    }
          }
          function designationFilter(pro,cat,task) {
                    var h= d3.nest()
                              .key(function(d) { return d.designation; })
                              .entries(users)
                    var designations= h.map(function (t) {
                              return t.key;
                    });
                    var mn=[];
                    var localTsheets=[];
                    if (pro==0 && cat ==0){
                              for (var d in designations) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == designations[d];
                                        });
                                        var ds= new Object();
                                        if (localTsheets.length<=0){
                                                  ds.key=designations[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localTsheets);
                                                  ds.key=designations[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }
                    else if (pro==0 && cat !=0){
                              for (var d in designations) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == designations[d];
                                        });
                                        var prodata= localTsheets.filter(function (t) {
                                                  if (task==0){
                                                            return getTaskById(t.task_id).task_category ==cat;
                                                  }else {
                                                            return (getTaskById(t.task_id).task_category== cat) && (t.task_id== task) ;
                                                  }
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=designations[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=designations[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }
                    else if (pro!=0 && cat ==0){
                              for (var d in designations) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == designations[d];
                                        });
                                        var prodata= localTsheets.filter(function (t) {
                                                  return t.project_id == pro;
                                        })
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=designations[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=designations[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }
                    else if (pro !=0 && cat !=0){
                              for (var d in designations) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == designations[d];
                                        });
                                        var prodata= localTsheets.filter(function (t) {
                                                  if (task==0){
                                                            return (getTaskById(t.task_id).task_category ==cat) && (t.project_id== pro) ;
                                                  }else {
                                                            return (getTaskById(t.task_id).task_category== cat) && (t.task_id== task) && (t.project_id== pro);
                                                  }
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=designations[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=designations[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }
                    return mn;
          }
          function sbuFilter(cat,des) {
                    var h= d3.nest()
                              .key(function(d) { return d.sbu; })
                              .entries(projects)
                    var sbu= h.map(function (t) {
                              return t.key;
                    });
                    var mn = [];

                    if (cat==0 && des==0){
                              for (var d in sbu) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == sbu[d];
                                        });
                                        var ds= new Object();
                                        if (localTsheets.length<=0){
                                                  ds.key=sbu[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localTsheets);
                                                  ds.key=sbu[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }

                    }
                    else if (cat==0 && des !=0){

                              for (var d in sbu) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == sbu[d];
                                        });
                                        var prodata= localTsheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == des;
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=sbu[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=sbu[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }



                    }
                    else if (cat !=0 && des==0){
                              for (var d in sbu) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == sbu[d];
                                        });
                                        var prodata= localTsheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == cat;
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=sbu[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=sbu[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }


                    }
                    else if (cat!=0 && des !=0){
                              for (var d in sbu) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == sbu[d];
                                        });
                                        var prodata= localTsheets.filter(function (t) {
                                                  return (getTaskById(t.task_id).task_category == cat) && (getUserById(t.user_id).designation == des);
                                        });
                                        var ds= new Object();
                                        if (prodata.length<=0){
                                                  ds.key=sbu[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(prodata);
                                                  ds.key=sbu[d];
                                                  ds.values= myd[0].values;
                                        }
                                        mn.push(ds);
                              }
                    }
                    return mn;
          }


          //------------------------------------------------------------------------------Function series to handle onclick Events of Buttons in UI
          document.getElementById("selectedProjects").onclick= function () {
                    var checkBoxes= document.getElementsByName("projectcheckbox[]");
                    var param = [];
                    for (var counter=0; counter < checkBoxes.length; counter++) {
                              if (checkBoxes[counter].type.toUpperCase()=='CHECKBOX' && checkBoxes[counter].checked == true) {
                                        param.push(checkBoxes[counter].value);
                              }
                    }
                     myprojects=param;

                    var pTimeSpend = [];
                    for (var count in myprojects) {
                              var localtimesheets = timesheets.filter(function (t) {
                                        return t.project_id == parseInt(myprojects[count]);
                              });
                              var myd = d3.nest()
                                        .key(function (d) {
                                                  return d.project_id;
                                        })
                                        .rollup(function (leaves) {
                                                  return d3.sum(leaves, function (d) {
                                                            return parseInt(d.timespent);
                                                  })
                                        })
                                        .entries(localtimesheets);
                              var ds = new Object();
                              ds.key = myprojects[count];
                              if (myd[0] == undefined) {
                                        ds.values = 0
                              } else {
                                        ds.values = myd[0].values;
                              }
                              pTimeSpend.push(ds);
                    }
                    projectHistoGram.update(pTimeSpend);

           };

          document.getElementById("projectsAxis").onclick=function () {
                    location.reload();
          };

          document.getElementById("goproject").onclick= function () {
                    var task= document.getElementById("ptask").value;
                    var cat= document.getElementById("pcategory").value;
                    var deg= document.getElementById("pdesignation").value;
                    projectHistoGram.update(projectsFilter(cat,task,deg));
                    taskPopulator(projectsFilter(cat,task,deg));
          };

          document.getElementById("categoryAxis").onclick=function () {
                    projectPopulator("project");
                    projectHistoGram.categoryHistoGram();
          };

          document.getElementById("gocategory").onclick=function () {
                    var deg= document.getElementById("designation").value;
                    var pro= document.getElementById("project").value;
                    projectHistoGram.categoryUpdater(categoryFilter(pro,deg));
          };

          document.getElementById("designationAxis").onclick= function () {
                    projectHistoGram.designationHistogram();
                    projectPopulator("dProject")
          };

          document.getElementById("goDesignation").onclick = function () {
                    var pro= document.getElementById("dProject").value;
                    var cat=document.getElementById("dCategory").value;
                    var task= document.getElementById("dTask").value;
                    projectHistoGram.designationUpdater(designationFilter(pro,cat,task));
          };
          document.getElementById("sbuAxis").onclick=function () {
                    projectHistoGram.sbuHistogram();
          }
          document.getElementById("goSbu").onclick=function () {
                    var cat=document.getElementById("sCategory").value;
                    var des=document.getElementById("sDesignation").value;
                    projectHistoGram.sbuUpdater(sbuFilter(cat,des));

          }
          document.getElementById("projectStack").onclick=function () {

                    var checkBoxes= document.getElementsByName("projectcheckbox[]");
                    var stackParameter= document.getElementById("projectStackOptions").value;
                    params = [];
                    for (var counter=0; counter < checkBoxes.length; counter++) {
                              if (checkBoxes[counter].type.toUpperCase()=='CHECKBOX' && checkBoxes[counter].checked == true) {
                                        params.push(checkBoxes[counter].value);
                              }
                    }
                    if (params.length>0){
                              myprojects=params;
                    }
                    if (stackParameter=="category"){
                              document.getElementById("pcategory").disabled = true;
                              document.getElementById("pdesignation").disabled = true;
                              projectHistoGram.pCategoryStack(myprojects);
                    }else if (stackParameter=="designation"){
                              document.getElementById("pcategory").disabled = true;
                              document.getElementById("pdesignation").disabled = true;
                              projectHistoGram.pDesignationStack(myprojects);
                    }else if (stackParameter==0){
                              location.reload();
                    }else if (stackParameter== "feeling"){
                              projectHistoGram.pFeelingStack(myprojects);
                    }
          }
          document.getElementById("categoryStack").onclick=function () {
                    var stackParameter= document.getElementById("categoryStackOptions").value;
                    if (stackParameter== "task"){
                              projectHistoGram.cTaskStack();
                    }else if (stackParameter == "designation"){
                              projectHistoGram.cDesignationStack();
                    }else if (stackParameter== 0){
                              console.log("No Stack for Category");
                    }else if (stackParameter== "feeling"){
                              projectHistoGram.cFeelingStack();
                    }else if (stackParameter=="sbu"){
                              projectHistoGram.cSbuStack();
                    }

          }

          document.getElementById("designationStack").onclick= function () {
                    var stackParameter= document.getElementById("designationCategoryOptions").value;
                    if(stackParameter==0){
                              projectHistoGram.designationHistogram();
                    }else if (stackParameter=="category"){
                              projectHistoGram.dCategoryStack();
                    }else if (stackParameter=="feeling"){
                              projectHistoGram.dFeelingStack();
                    }else if (stackParameter== "sbu"){
                              projectHistoGram.dSbuStack();
                    }

          }
          document.getElementById("sbuStack").onclick=function () {
                    var stackParameter= document.getElementById("sbuStackOption").value;
                    if(stackParameter==0){
                              projectHistoGram.sbuHistogram();
                    }else if (stackParameter=="category"){
                             projectHistoGram.sCategoryStack();
                    }else if (stackParameter=="feeling"){
                              projectHistoGram.sFeelingStack();
                    }else if (stackParameter== "designation"){
                              projectHistoGram.sDesignationStack();
                    }

          }
          //-------------------------------------------------------------------------------Function series to handle onchange events of Selections in UI
                   document.getElementById("pcategory").onchange = function() {
                    var cat= document.getElementById("pcategory").value;
                    var id="ptask";
                              taskPopulator(cat,id);
          };

          document.getElementById("dCategory").onchange= function () {
                    var cat= document.getElementById("dCategory").value;
                    var id="dTask";
                    taskPopulator(cat,id);
          }


          //--------------------------------------------------------------function to Populate projects in drop down
          function projectPopulator(id) {
                    var selector;
                    if (id== "project"){
                              selector= document.getElementById("project");
                    }else {
                              selector= document.getElementById("dProject");
                    }
                    for (var i = 0; i < projects.length; i++) {
                              var opt = projects[i];
                              var el = document.createElement("option");
                              el.textContent = opt.projectname;
                              el.value = opt.id;
                              selector.appendChild(el);
                    }
          }
          function taskPopulator (cat,id) {
                    var selector,tsk;
                    if (id=="ptask"){
                               selector= document.getElementById("ptask");
                               tsk=d3.select("#ptask");
                    }else if (id="dTask"){
                              selector= document.getElementById("dTask");
                              tsk=d3.select("#dTask");
                    }
                    tsk.selectAll('option').remove();
                    if (cat==0){
                              var opt = document.createElement("option");
                              opt.textContent = "All Tasks";
                              opt.value = 0;
                              selector.appendChild(opt);
                    }else {
                              var mytasks = tasks.filter(function (d) {
                                        return d.task_category == cat;
                              });
                              var opt = document.createElement("option");
                              opt.textContent = "All Tasks";
                              opt.value = 0;
                              selector.appendChild(opt);
                              for (var i = 0; i < mytasks.length; i++) {
                                        var opt = mytasks[i];
                                        var el = document.createElement("option");
                                        el.textContent = opt.taskname;
                                        el.value = opt.id;
                                        selector.appendChild(el);
                              }
                    }
          }


          //-----------------------------------------------------------------------------------Function to Create Histogram by Default Projects Histogram
          function projectHistogram() {
                    var hG = {}, hGDim = {t: 30, r: 30, b: 100, l: 80};
                    hGDim.w = 800 - hGDim.l - hGDim.r,
                              hGDim.h = 600 - hGDim.t - hGDim.b;

                    var axisPadding = 3;


                    var feelings= [1,2,3,4,5];
                    var expressions= ["Very Sad","Sad","Neutral","Happy","Very Happy"];

                    var expression= d3.scale.ordinal()
                              .domain(feelings)
                              .range(expressions);


                    function hGData(s) {
                              var data = [];
                              for (var i = 0; i < s.length; ++i)
                                        data.push(s[i].values);
                              return data;
                    }

                    var pTimeSpend = [];
                    for (var count in myprojects) {
                             var localtimesheets = timesheets.filter(function (t) {
                                        return t.project_id == parseInt(myprojects[count]);
                              });
                             var myd = d3.nest()
                                        .key(function (d) {
                                                  return d.project_id;
                                        })
                                        .rollup(function (leaves) {
                                                  return d3.sum(leaves, function (d) {
                                                            return parseInt(d.timespent);
                                                  })
                                        })
                                        .entries(localtimesheets);
                              var ds = new Object();
                              ds.key = myprojects[count];
                              if (myd[0] == undefined) {
                                        ds.values = 0
                              } else {
                                        ds.values = myd[0].values;
                              }
                              pTimeSpend.push(ds);
                    }
                   // d3.select("#projectBarGraph").select('svg').remove();
                    var svg= d3.select("#projectBarGraph")
                              .append("svg")
                              .attr("width", (hGDim.w+ hGDim.l + hGDim.r))
                              .attr("height", (hGDim.h+hGDim.t + hGDim.b));
                    var canvas = svg
                              .append('g')
                              .attr('transform', 'translate(' + hGDim.l + ',' + hGDim.t + ")");
                    var x = d3.scale.ordinal().rangeRoundBands([0, hGDim.w], 0.1)
                              .domain(pTimeSpend.map(function (d) {
                                        return getProjectById(d.key).projectname;
                              }));
                    var y = d3.scale.linear().range([hGDim.h, 0])
                              .domain([0, d3.max(hGData(pTimeSpend))]);

                    var axisGroup = svg.append('g')
                              .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                    var axis = d3.svg.axis().scale(x);
                    var axisNodes = axisGroup.call(axis);
                    styleAxisNodes(axisNodes);

                    var leftAxisGroup = svg.append('g')
                              .attr('transform', 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')');

                    var leftAxis = d3.svg.axis()
                              .orient('left')
                              .scale(y);
                    var leftAxisNodes = leftAxisGroup.call(leftAxis);
                    styleLeftAxisNodes(leftAxisNodes);

                    function styleLeftAxisNodes(axisNodes) {
                              axisNodes.selectAll(".domain")
                                        .attr({
                                                  fill: 'none',
                                                  'stroke-width': 1,
                                                  stroke: 'black'
                                        });
                              axisNodes.selectAll(".tick line")
                                        .attr({
                                                  fill: 'none',
                                                  'stroke-width': 1,
                                                  stroke: 'black'
                                        });

                    }

                    function styleAxisNodes(axisNodes) {
                              axisNodes.selectAll(".domain")
                                        .attr({
                                                  fill: 'none',
                                                  'stroke-width': 1,
                                                  stroke: 'black'
                                        });
                              axisNodes.selectAll(".tick line")
                                        .attr({
                                                  fill: 'none',
                                                  'stroke-width': 1,
                                                  stroke: 'black'
                                        });
                              axisNodes.selectAll("text")
                                        .style('text-anchor', 'start')
                                        .attr({
                                                  dx: 10,
                                                  dy: -5,
                                                  transform: 'rotate(60)'
                                        });

                    }

                    var tip = d3.tip()
                              .attr('class', 'd3-tip')
                              .offset([-10, 0])
                              .html(function(d) {
                                        return "<strong>"+ getProjectById(d.key).projectname+":</strong> <span style='color:white'>" + d.values + "</span>";
                              });
                    canvas.call(tip);
                    var bars = canvas.selectAll("g")
                              .data(pTimeSpend)
                              .enter()
                              .append('g');
                    //---------------------------Calling legend for Displaying Relevant
                    var bL=barLegend(pTimeSpend);
                    bars.append("rect")
                              .attr("x", function (d, i) {
                                        return x.range()[i];
                              })
                              .attr("y", function (d) {
                                        return y(d.values)
                              })
                              .attr("width", x.rangeBand())
                              .attr("height", function (d) {
                                        return hGDim.h - y(d.values)
                              })
                              .attr("fill", function (d, i) {
                                        return COLOR(i);
                              })
                              .on("mouseover", tip.show)
                              .on("mouseout", tip.hide);

                    //------------------------------------------------------Function to Update Histogram(Bar Graph) according to filters applied
                    hG.update = function(a){
                              //console.log(a);
                              bL.update(a);
                              y.domain([0, d3.max(a, function(d) { return d.values; })]);
                              x.domain(a.map(function(d) { return getProjectById(d.key).projectname; }));

                              canvas.selectAll('g').remove();
                              axisGroup.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();
                              axisGroup = svg.append('g')
                                        .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                              var axis = d3.svg.axis().scale(x);
                              var axisNodes = axisGroup.call(axis);
                              styleAxisNodes(axisNodes);
                               leftAxisGroup = svg.append('g')
                                         .attr({
                                        transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                              });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var bars = canvas.selectAll(".bar")
                                         .data(a);
                               var entering= bars.enter();
                               var group= entering.append("g");

                               group.append("rect")
                                         .attr("x",function (d,i) {  return x.range()[i] ;    })
                                         .attr("y", function (d) { return y(d.values) })
                                         .attr("width",x.rangeBand())
                                         .attr("height", function (d) { return hGDim.h - y(d.values) })
                                         .attr("fill",function (d,i) {
                                                   return COLOR(i);
                                         })
                                         .on("mouseover", tip.show)
                                         .on("mouseout", tip.hide);
                    }
                    //-----------------------------------------------------------------function to create Category Histogram
                    hG.categoryHistoGram= function () {
                              var h= d3.nest()
                                        .key(function(d) { return d.task_category; })
                                        .entries(tasks)
                              var categories= h.map(function (t) {
                                        return t.key;
                              });
                              var cTimeSpend = [];
                              for (var c in categories) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == categories[c];
                                        });
                                        var ds= new Object();
                                        if (localTsheets.length<=0){
                                                  ds.key=categories[c];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localTsheets);
                                                  ds.key=categories[c];
                                                  ds.values= myd[0].values;
                                        }
                                        cTimeSpend.push(ds);
                              }
                              bL.categoryLegend(cTimeSpend);

                               y.domain([0, d3.max(cTimeSpend, function(d) { return d.values; })]);
                               x.domain(cTimeSpend.map(function(d) { return d.key; }));
                               canvas.selectAll('g').remove();
                              axisGroup.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                               axisGroup = svg.append('g')
                                        .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                              var axis = d3.svg.axis().scale(x);
                              var axisNodes = axisGroup.call(axis);
                              styleAxisNodes(axisNodes);

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d) {
                                                  return "<strong>"+ d.key +":</strong> <span style='color:white'>" + d.values + "</span>";
                                        });
                              canvas.call(tip);
                               var bars = canvas.selectAll(".bar")
                                         .data(cTimeSpend);
                               var entering= bars.enter();
                               var group= entering.append("g");
                               group.append("rect")
                                        .attr("x",function (d,i) {  return x.range()[i] ;    })
                                        .attr("y", function (d) { return y(d.values) })
                                        .attr("width",x.rangeBand())
                                        .attr("height", function (d) { return hGDim.h - y(d.values) })
                                        .attr("fill",function (d,i) {
                                                  return COLOR(i);
                                        })
                                         .on("mouseover", tip.show)
                                         .on("mouseout", tip.hide);
                    }
                    //-----------------------------------------------------------------------------------function to update category histogram
                    hG.categoryUpdater=function (a) {
                              bL.categoryLegendUpdater(a);
                              y.domain([0, d3.max(a, function(d) { return d.values; })]);
                              x.domain(a.map(function(d) { return d.key; }));

                              canvas.selectAll('g').remove();
                              axisGroup.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              axisGroup = svg.append('g')
                                        .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                              var axis = d3.svg.axis().scale(x);
                              var axisNodes = axisGroup.call(axis);
                              styleAxisNodes(axisNodes);

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);

                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d) {
                                                  return "<strong>"+ d.key +":</strong> <span style='color:white'>" + d.values + "</span>";
                                        });
                              canvas.call(tip);
                              var bars = canvas.selectAll(".bar")
                                        .data(a);
                              var entering= bars.enter();
                              var group= entering.append("g");
                              group.append("rect")
                                        .attr("x",function (d,i) {  return x.range()[i] ;    })
                                        .attr("y", function (d) { return y(d.values) })
                                        .attr("width",x.rangeBand())
                                        .attr("height", function (d) { return hGDim.h - y(d.values) })
                                        .attr("fill",function (d,i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover", tip.show)
                                        .on("mouseout", tip.hide);
                    }

                    //----------------------------------------------------------------function to create Designation Histogram
                    hG.designationHistogram=function () {
                              var h= d3.nest()
                                        .key(function(d) { return d.designation; })
                                        .entries(users)
                              var designations= h.map(function (t) {
                                        return t.key;
                              });
                              var dTimeSpend = [];
                              for (var d in designations) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == designations[d];
                                        });
                                        var ds= new Object();
                                        if (localTsheets.length<=0){
                                                  ds.key=designations[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localTsheets);
                                                  ds.key=designations[d];
                                                  ds.values= myd[0].values;
                                        }
                                        dTimeSpend.push(ds);
                              }
                              //-------------------------------------------------------function call to update designation legend according to bars
                              bL.designationLegend(dTimeSpend);
                              y.domain([0, d3.max(dTimeSpend, function(d) { return d.values; })]);
                              x.domain(dTimeSpend.map(function(d) { return d.key; }));
                              canvas.selectAll('g').remove();
                              axisGroup.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              axisGroup = svg.append('g')
                                        .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                              var axis = d3.svg.axis().scale(x);
                              var axisNodes = axisGroup.call(axis);
                              styleAxisNodes(axisNodes);

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d) {
                                                  return "<strong>"+ d.key +":</strong> <span style='color:white'>" + d.values + "</span>";
                                        });
                              canvas.call(tip);
                              var bars = canvas.selectAll(".bar")
                                        .data(dTimeSpend);
                              var entering= bars.enter();
                              var group= entering.append("g");
                              group.append("rect")
                                        .attr("x",function (d,i) {  return  x.range()[i] ;    })
                                        .attr("y", function (d) { return y(d.values) })
                                        .attr("width",x.rangeBand())
                                        .attr("height", function (d) { return hGDim.h - y(d.values) })
                                        .attr("fill",function (d,i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover", tip.show)
                                        .on("mouseout", tip.hide);
                    }

                    //------------------------------------------------------------------function to update designation in bar graph
                    hG.designationUpdater= function (a) {
                              //--------------------------------------------- function call for legend data update
                              bL.designationLegendUpdater(a);
                              y.domain([0, d3.max(a, function(d) { return d.values; })]);
                              x.domain(a.map(function(d) { return d.key; }));
                              canvas.selectAll('g').remove();
                              axisGroup.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              axisGroup = svg.append('g')
                                        .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                              var axis = d3.svg.axis().scale(x);
                              var axisNodes = axisGroup.call(axis);
                              styleAxisNodes(axisNodes);

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d) {
                                                  return "<strong>"+ d.key +":</strong> <span style='color:white'>" + d.values + "</span>";
                                        });
                              canvas.call(tip);
                              var bars = canvas.selectAll(".bar")
                                        .data(a);
                              var entering= bars.enter();
                              var group= entering.append("g");
                              group.append("rect")
                                        .attr("x",function (d,i) {  return x.range()[i]  ;    })
                                        .attr("y", function (d) { return y(d.values) })
                                        .attr("width",x.rangeBand())
                                        .attr("height", function (d) { return hGDim.h - y(d.values) })
                                        .attr("fill",function (d,i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover", tip.show)
                                        .on("mouseout", tip.hide);
                    }

                    hG.sbuHistogram=function () {
                              var h= d3.nest()
                                        .key(function(d) { return d.sbu; })
                                        .entries(projects)
                              var sbu= h.map(function (t) {
                                        return t.key;
                              });
                              var dTimeSpend = [];
                              for (var d in sbu) {
                                        var localTsheets = timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == sbu[d];
                                        });
                                        var ds= new Object();
                                        if (localTsheets.length<=0){
                                                  ds.key=sbu[d];
                                                  ds.values= 0;
                                        }else {
                                                  var myd= d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localTsheets);
                                                  ds.key=sbu[d];
                                                  ds.values= myd[0].values;
                                        }
                                        dTimeSpend.push(ds);
                              }
                              // //-------------------------------------------------------function call to update designation legend according to bars
                              bL.sbuLegend(dTimeSpend);
                              y.domain([0, d3.max(dTimeSpend, function(d) { return d.values; })]);
                              x.domain(dTimeSpend.map(function(d) { return d.key; }));
                              canvas.selectAll('g').remove();
                              axisGroup.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              axisGroup = svg.append('g')
                                        .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                              var axis = d3.svg.axis().scale(x);
                              var axisNodes = axisGroup.call(axis);
                              styleAxisNodes(axisNodes);

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d) {
                                                  return "<strong>"+ d.key +":</strong> <span style='color:white'>" + d.values + " Mins</span>";
                                        });
                              canvas.call(tip);
                              var bars = canvas.selectAll(".bar")
                                        .data(dTimeSpend);
                              var entering= bars.enter();
                              var group= entering.append("g");
                              group.append("rect")
                                        .attr("x",function (d,i) {  return  x.range()[i] ;    })
                                        .attr("y", function (d) { return y(d.values) })
                                        .attr("width",x.rangeBand())
                                        .attr("height", function (d) { return hGDim.h - y(d.values) })
                                        .attr("fill",function (d,i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover", tip.show)
                                        .on("mouseout", tip.hide);


                    }
                    hG.sbuUpdater=function (a) {
                              bL.sbuLegendUpdater(a);
                              y.domain([0, d3.max(a, function(d) { return d.values; })]);
                              x.domain(a.map(function(d) { return d.key; }));
                              canvas.selectAll('g').remove();
                              axisGroup.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              axisGroup = svg.append('g')
                                        .attr('transform', 'translate(' + hGDim.l + ',' +(hGDim.h+ hGDim.t ) + ")");
                              var axis = d3.svg.axis().scale(x);
                              var axisNodes = axisGroup.call(axis);
                              styleAxisNodes(axisNodes);

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d) {
                                                  return "<strong>"+ d.key +":</strong> <span style='color:white'>" + d.values + "</span>";
                                        });
                              canvas.call(tip);
                              var bars = canvas.selectAll(".bar")
                                        .data(a);
                              var entering= bars.enter();
                              var group= entering.append("g");
                              group.append("rect")
                                        .attr("x",function (d,i) {  return x.range()[i]  ;    })
                                        .attr("y", function (d) { return y(d.values) })
                                        .attr("width",x.rangeBand())
                                        .attr("height", function (d) { return hGDim.h - y(d.values) })
                                        .attr("fill",function (d,i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover", tip.show)
                                        .on("mouseout", tip.hide);




                    }
                    //----------------------------------------------------------------------function to create category wise stacked bar graph
                    hG.pCategoryStack= function (myprojects) {

                              var h= d3.nest()
                                        .key(function(d) { return d.task_category; })
                                        .entries(tasks);
                              var categories= h.map(function (t) {
                                        return t.key;
                              });
                              var mydata= categories.map(function (c) {
                                        return myprojects.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== t.project_id) && (c==  getTaskById(t.task_id).task_category);
                                                  });
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return d.project_id;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });

                              bL.pCategoryStack(myprojects,categories);
                             var stackedData = d3.layout.stack()(mydata);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.1);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);




                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ categories[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());


                    }
                    hG.pDesignationStack=function (myprojects) {

                              var h= d3.nest()
                                        .key(function(d) { return d.designation; })
                                        .entries(users);
                              var designations= h.map(function (t) {
                                        return t.key;
                              });
                              var mydata= designations.map(function (c) {
                                        return myprojects.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== t.project_id) && (c==  getUserById(t.user_id).designation);
                                                  });
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return d.project_id;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });


                              bL.pDesignationStack(myprojects,designations);
                              var stackedData = d3.layout.stack()(mydata);

                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ designations[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());
//                                        .on("mouseover", mouseover())
                              //                                     .on("mouseout", tip.hide);

                    }
                    hG.pFeelingStack= function (myprojects) {

                              var mydata= feelings.map(function (c) {
                                        return myprojects.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== t.project_id) && (c==  t.feeling);
                                                  });
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return d.project_id;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return leaves.length;
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });
                              bL.pFeelingStack(myprojects,feelings);
                              var stackedData = d3.layout.stack()(mydata);
                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ expression(feelings[i]) +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());

                    }
                    hG.cTaskStack= function () {

                              var h= d3.nest()
                                        .key(function(d) { return d.task_category; })
                                        .entries(tasks);
                              var categories= h.map(function (t) {
                                        return t.key;
                              });
                              var mytasks= tasks.map(function (t) {
                                        return t.id;
                              });
                              //console.log(mytasks);

                              var mydata=  mytasks.map(function (c) {
                                        return categories.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== getTaskById(t.task_id).task_category) && (c== t.task_id);
                                                  });
                                                  var pTimeSpend= d3.nest()
                                                            .key(function (d) {
                                                                      getTaskById(parseInt(d.task_id)).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves,function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);

                                                  var a= pTimeSpend.map(function (d) {
                                                            return {
                                                                      x: d.key,
                                                                      y:d.values
                                                            }
                                                  })
                                                  //console.log(pTimeSpend);
                                                  if (a[0] == undefined ){
                                                            return {
                                                                      x: mp ,
                                                                      y:0
                                                            }
                                                  }else {
                                                            //console.log(a[0]);
                                                            return a[0];
                                                  }
                                        });
                              });
                              var stackedData = d3.layout.stack()(mydata);


                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);

                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.1);

                              bL.cTaskStack(categories,mytasks);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ getTaskById(mytasks[i]).taskname +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);

                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());




                    }
                    hG.cDesignationStack = function () {

                              var h= d3.nest()
                                        .key(function(d) { return d.designation; })
                                        .entries(users);
                              var designations= h.map(function (t) {
                                        return t.key;
                              });
                              var l= d3.nest().key(function (d) {
                                        return d.task_category ;
                              }).entries(tasks);
                              var categories= l.map(function (d) {
                                        return d.key;
                              });

                              var mydata= designations.map(function (des) {
                                        return categories.map(function (cat) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                  return (getTaskById(t.task_id).task_category == cat) && (getUserById(t.user_id).designation== des);
                                                  })
                                                 // console.log(localtimesheets);
                                                  var cTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category ;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= cTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  });
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: cat,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }


                                        });
                              });


                              bL.cDesignationStack(designations,categories);



                              var stackedData = d3.layout.stack()(mydata);

                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);






                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ designations[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());




                    }
                    hG.cFeelingStack=function () {
                              var h= d3.nest()
                                        .key(function(d) { return d.task_category; })
                                        .entries(tasks);
                              var categories= h.map(function (t) {
                                        return t.key;
                              });
                              var mydata= feelings.map(function (f) {
                                        return categories.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== getTaskById(t.task_id).task_category) && (f==  t.feeling);
                                                  });
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return leaves.length;
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });
                              bL.cFeelingStack(categories,feelings);
                              var stackedData = d3.layout.stack()(mydata);
                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ expression(feelings[i]) +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());



                    }
                    hG.cSbuStack=function () {
                              var raw= d3.nest().key(function (p) {
                                        return p.sbu;
                              }).entries(projects);
                              var sbu=raw.map(function (s) {
                                        return s.key;
                              });
                              var h= d3.nest()
                                        .key(function(d) { return d.task_category; })
                                        .entries(tasks);
                              var categories= h.map(function (t) {
                                        return t.key;
                              });
                              var mydata= sbu.map(function (f) {
                                        return categories.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== getTaskById(t.task_id).task_category) && (f== getProjectById(t.project_id).sbu );
                                                  });
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getTaskById(d.task_id).task_category;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });
                              bL.cSbuStack(categories,sbu);
                              var stackedData = d3.layout.stack()(mydata);
                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ sbu[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());





                    }
                    hG.dCategoryStack=function () {
                              var h= d3.nest()
                                        .key(function(d) { return d.designation; })
                                        .entries(users);
                              var designations= h.map(function (t) {
                                        return t.key;
                              });
                              var l= d3.nest().key(function (d) {
                                        return d.task_category ;
                              }).entries(tasks);
                              var categories= l.map(function (d) {
                                        return d.key;
                              });

                              var mydata= categories.map(function (cat) {
                                        return designations.map(function (des) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (getTaskById(t.task_id).task_category == cat) && (getUserById(t.user_id).designation== des);
                                                  })
                                                  // console.log(localtimesheets);
                                                  var cTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation ;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= cTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  });
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: des,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }


                                        });
                              });

                              canvas.selectAll('g').remove();

                              bL.dCategoryStack(designations,categories);



                              var stackedData = d3.layout.stack()(mydata);

                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ categories[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);

                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());

                    }
                    hG.dFeelingStack=function () {
                              var h= d3.nest()
                                        .key(function(d) { return d.designation; })
                                        .entries(users);
                              var designations= h.map(function (t) {
                                        return t.key;
                              });

                              var mydata= feelings.map(function (cat) {
                                        return designations.map(function (des) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (t.feeling == cat) && (getUserById(t.user_id).designation== des);
                                                  })
                                                  // console.log(localtimesheets);
                                                  var cTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation ;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return leaves.length;
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= cTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  });
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: des,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }


                                        });
                              });

                              canvas.selectAll('g').remove();

                              bL.dFeelingStack(designations,feelings);

                              var stackedData = d3.layout.stack()(mydata);

                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ expression(feelings[i]) +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);

                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());


                    }
                    hG.dSbuStack=function () {
                              var h= d3.nest()
                                        .key(function(d) { return d.designation; })
                                        .entries(users);
                              var designations= h.map(function (t) {
                                        return t.key;
                              });
                              var raw= d3.nest().key(function (p) {
                                        return p.sbu;
                              }).entries(projects);
                              var sbu=raw.map(function (s) {
                                        return s.key;
                              });
                              var mydata= sbu.map(function (f) {
                                        return designations.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== getUserById(t.user_id).designation) && (f== getProjectById(t.project_id).sbu );
                                                  });
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getUserById(d.user_id).designation;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });
                              bL.dSbuStack(designations,sbu);
                              var stackedData = d3.layout.stack()(mydata);
                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ sbu[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());

                    }
                    hG.sCategoryStack=function () {
                              var raw= d3.nest().key(function (p) {
                                        return p.sbu;
                              }).entries(projects);
                              var sbu=raw.map(function (s) {
                                        return s.key;
                              });
                              var h= d3.nest()
                                        .key(function(d) { return d.task_category; })
                                        .entries(tasks);
                              var categories= h.map(function (t) {
                                        return t.key;
                              });
                              var mydata= categories.map(function (f) {
                                        return sbu.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (f== getTaskById(t.task_id).task_category) && (mp== getProjectById(t.project_id).sbu );
                                                  });
                                                  //console.log(localtimesheets);
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });

                              bL.sCategoryStack(categories,sbu);
                              var stackedData = d3.layout.stack()(mydata);
                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ categories[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());








                    }
                    hG.sFeelingStack=function () {
                              var raw= d3.nest().key(function (p) {
                                        return p.sbu;
                              }).entries(projects);
                              var sbu=raw.map(function (s) {
                                        return s.key;
                              });

                              var mydata= feelings.map(function (cat) {
                                        return sbu.map(function (des) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (t.feeling == cat) && (getProjectById(t.project_id).sbu== des);
                                                  })
                                                  // console.log(localtimesheets);
                                                  var cTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu ;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return leaves.length;
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= cTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  });
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: des,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }


                                        });
                              });

                              canvas.selectAll('g').remove();

                              bL.sFeelingStack(sbu,feelings);

                              var stackedData = d3.layout.stack()(mydata);

                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);


                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ expression(feelings[i]) +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);

                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());

















                    }
                    hG.sDesignationStack=function () {

                              var h= d3.nest()
                                        .key(function(d) { return d.designation; })
                                        .entries(users);
                              var designations= h.map(function (t) {
                                        return t.key;
                              });
                              var raw= d3.nest().key(function (p) {
                                        return p.sbu;
                              }).entries(projects);
                              var sbu=raw.map(function (s) {
                                        return s.key;
                              });
                              var mydata= designations.map(function (f) {
                                        return sbu.map(function (mp) {
                                                  var localtimesheets= timesheets.filter(function (t) {
                                                            return (mp== getProjectById(t.project_id).sbu) && (f== getUserById(t.user_id).designation );
                                                  });
                                                  var pTimeSpend=d3.nest()
                                                            .key(function (d) {
                                                                      return getProjectById(d.project_id).sbu;
                                                            })
                                                            .rollup(function (leaves) {
                                                                      return d3.sum(leaves, function (d) {
                                                                                return parseInt(d.timespent);
                                                                      })
                                                            })
                                                            .entries(localtimesheets);
                                                  var a= pTimeSpend.map(function (d) {
                                                            return{
                                                                      x: d.key,
                                                                      y: d.values
                                                            }
                                                  })
                                                  if (a[0]== undefined){
                                                            return {
                                                                      x: mp,
                                                                      y:0
                                                            }
                                                  }else {
                                                            return a[0];
                                                  }

                                        });
                              });
                              bL.sDesignationStack(designations,sbu);
                              var stackedData = d3.layout.stack()(mydata);
                              var yScale = d3.scale.linear()
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ])
                                        .range([0, hGDim.h]);
                              var xScale = d3.scale.ordinal()
                                        .domain(d3.range(stackedData[0].length))
                                        .rangeRoundBands([0, hGDim.w], 0.05);


                              var y = d3.scale.linear().range([hGDim.h, 0])
                                        .domain([0,
                                                  d3.max(stackedData, function (d) {
                                                            return d3.max(d, function (d) {
                                                                      return d.y0 + d.y;
                                                            });
                                                  })
                                        ]);

                              canvas.selectAll('g').remove();
                              leftAxisGroup.selectAll('g').remove();

                              leftAxisGroup = svg.append('g')
                                        .attr({
                                                  transform: 'translate(' + (hGDim.l- axisPadding ) + ',' + hGDim.t + ')'
                                        });

                              var leftAxis = d3.svg.axis()
                                        .orient('left')
                                        .scale(y);
                              var leftAxisNodes = leftAxisGroup.call(leftAxis);
                              styleLeftAxisNodes(leftAxisNodes);



                              var tip = d3.tip()
                                        .attr('class', 'd3-tip')
                                        .offset([-10, 0])
                                        .html(function(d,i) {
                                                  return "<strong>"+ designations[i] +"</strong> <span style='color:white'></span>";
                                        });
                              canvas.call(tip);

                              var groups = canvas.selectAll("g")
                                        .data(stackedData)
                                        .enter()
                                        .append("g")
                                        .style("fill", function (d, i) {
                                                  return COLOR(i);
                                        })
                                        .on("mouseover",tip.show)
                                        .on("mouseout", tip.hide);
                              groups.selectAll("rect")
                                        .data(function (d) { return d; })
                                        .enter()
                                        .append("rect")
                                        .attr("x", function (d, i) {
                                                  return xScale(i);
                                        })
                                        .attr("y", function (d, i) {
                                                  return hGDim.h - yScale(d.y) - yScale(d.y0);
                                        })
                                        .attr("height", function (d) {
                                                  return yScale(d.y);
                                        })
                                        .attr("width", xScale.rangeBand());














                    }

                    return hG;
          }








          //------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          //--------------------------------------------------------------function to create legend by default projects
          //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          function barLegend(data) {
                    var bLeg={};

                    var feelings= [1,2,3,4,5];
                    var expressions= ["Very Sad","Sad","Neutral","Happy","Very Happy"];

                    var expression= d3.scale.ordinal()
                              .domain(feelings)
                              .range(expressions);
                    d3.select("#accordion").remove();
                    d3.select("#barlegend").select("ul").remove();
                    var legend= d3.select("#barlegend")
                              .append("ul")
                              .attr("class","list-group");
                    legend.selectAll('li').remove();
                    var selector = legend.selectAll("li")
                              .data(data);
                    var tr= selector.enter()
                              .append("li")
                              .attr('class','list-group-item');
                    var exiting= selector.exit();
                    exiting.remove();
                    tr.text(function(d){ return (getProjectById(d.key).projectname+" :- ( "+d.values +"   Min. )");})
                              .style("background",function (d,i) {
                                        return COLOR(i);
                              });

                    //---------------------------------------------------------Legend Update function to incorporate new changes
                    bLeg.update=function (d) {
                              d3.select("#accordion").remove();
                              d3.select("#barlegend").select("ul").remove();
                              var legend= d3.select("#barlegend")
                                        .append("ul")
                                        .attr("class","list-group");
                              legend.selectAll('li').remove();

                              var selector = legend.selectAll("li")
                                        .data(d);
                              var tr= selector.enter()
                                        .append("li")
                                        .attr('class','list-group-item');
                              tr.text(function(d){ return (getProjectById(d.key).projectname+" :- ( "+d.values +"   Min. )");})
                                        .style("background",function (d,i) {
                                                  return COLOR(i);
                                        });
                    }

                    //----------------------------------------------------------------function to populate category data in legend
                    bLeg.categoryLegend= function (d) {
                              d3.select("#accordion").remove();
                              d3.select("#barlegend").select("ul").remove();
                              var legend= d3.select("#barlegend")
                                        .append("ul")
                                        .attr("class","list-group");
                              legend.selectAll('li').remove();
                              var selector = legend.selectAll("li")
                                        .data(d);
                              var tr= selector.enter()
                                        .append("li")
                                        .attr('class','list-group-item');
                              tr.text(function(d){ return (d.key+" :- ( "+d.values +"   Min. )");})
                                        .style("background",function (d,i) {
                                                  return COLOR(i);
                                        });
                    }

                    //-------------------------------------------------------------------function to update category legend
                    bLeg.categoryLegendUpdater=function (d) {
                              d3.select("#accordion").remove();
                              d3.select("#barlegend").select("ul").remove();
                              var legend= d3.select("#barlegend")
                                        .append("ul")
                                        .attr("class","list-group");
                              legend.selectAll('li').remove();

                              var selector = legend.selectAll("li")
                                        .data(d);
                              var tr= selector.enter()
                                        .append("li")
                                        .attr('class','list-group-item');
                              tr.text(function(d){ return (d.key+" :- ( "+d.values +"   Min. )");})
                                        .style("background",function (d,i) {
                                                  return COLOR(i);
                                        });
                    }

                    //-------------------------------------------------------------function to create a legend for designation
                    bLeg.designationLegend= function (d) {
                              d3.select("#accordion").remove();
                              d3.select("#barlegend").select("ul").remove();
                              var legend= d3.select("#barlegend")
                                        .append("ul")
                                        .attr("class","list-group");
                              legend.selectAll('li').remove();
                              var selector = legend.selectAll("li")
                                        .data(d);
                              var tr= selector.enter()
                                        .append("li")
                                        .attr('class','list-group-item');
                              tr.text(function(d){ return (d.key+" :- ( "+d.values +"   Min. )");})
                                        .style("background",function (d,i) {
                                                  return COLOR(i);
                                        });
                    }

                    bLeg.designationLegendUpdater=function (d) {
                              d3.select("#barlegend").select("ul").remove();
                              d3.select("#accordion").remove();
                              var legend = d3.select("#barlegend")
                                        .append("ul")
                                        .attr("class","list-group");

                              var selector = legend.selectAll("li")
                                        .data(d);
                              var tr= selector.enter()
                                        .append("li")
                                        .attr('class','list-group-item');
                              tr.text(function(d){ return (d.key+" :- ( "+d.values +"   Min. )");})
                                        .style("background",function (d,i) {
                                                  return COLOR(i);
                                        });
                    }

                    bLeg.sbuLegend=function (d) {
                              d3.select("#accordion").remove();
                              d3.select("#barlegend").select("ul").remove();
                              var legend= d3.select("#barlegend")
                                        .append("ul")
                                        .attr("class","list-group");
                              legend.selectAll('li').remove();
                              var selector = legend.selectAll("li")
                                        .data(d);
                              var tr= selector.enter()
                                        .append("li")
                                        .attr('class','list-group-item');
                              tr.text(function(d){ return (d.key+" :- ( "+d.values +"   Min. )");})
                                        .style("background",function (d,i) {
                                                  return COLOR(i);
                                        });

                    }
                    bLeg.sbuLegendUpdater=function (d) {
                              d3.select("#accordion").remove();
                              d3.select("#barlegend").select("ul").remove();
                              var legend= d3.select("#barlegend")
                                        .append("ul")
                                        .attr("class","list-group");
                              legend.selectAll('li').remove();
                              var selector = legend.selectAll("li")
                                        .data(d);
                              var tr= selector.enter()
                                        .append("li")
                                        .attr('class','list-group-item');
                              tr.text(function(d){ return (d.key+" :- ( "+d.values +"   Min. )");})
                                        .style("background",function (d,i) {
                                                  return COLOR(i);
                                        });
                    }
                    //----------------------------------------------------------------function to create a Legend for Stacked Bar Graph Projects by Category
                    bLeg.pCategoryStack= function (p,c) {

                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in p){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return t.project_id== p[i];
                                        });
                                        var pTime= d3.nest()
                                                  .key(function (d) {
                                                            return d.project_id;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                              var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+getProjectById(pTime[0].key).projectname.toLowerCase().replace(/ +/g, ""));
                                        ancher.text=getProjectById(pTime[0].key).projectname + " :- " +pTime[0].values +" Mins" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=getProjectById(pTime[0].key).projectname.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in c) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return getTaskById(t.task_id).task_category == c[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=c[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getTaskById(d.task_id).task_category;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=c[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key+" :- "+ ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);
                    }
                    bLeg.pDesignationStack=function (p,c) {

                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in p){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return t.project_id== p[i];
                                        });
                                        var pTime= d3.nest()
                                                  .key(function (d) {
                                                            return d.project_id;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+getProjectById(pTime[0].key).projectname.toLowerCase().replace(/ +/g, ""));
                                        ancher.text=getProjectById(pTime[0].key).projectname + " :- " +pTime[0].values +" Mins" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=getProjectById(pTime[0].key).projectname.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in c) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return getUserById(t.user_id).designation == c[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=c[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getUserById(d.user_id).designation;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=c[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key+" :- "+ ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);
                    }
                    bLeg.pFeelingStack=function (p,f) {
                              //console.log(p,f)
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";

                              for (i in p){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return t.project_id== p[i];
                                        });
                                        var pTime= d3.nest()
                                                  .key(function (d) {
                                                            return d.project_id;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return leaves.length;
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+getProjectById(pTime[0].key).projectname.toLowerCase().replace(/ +/g, ""));
                                        ancher.text=getProjectById(pTime[0].key).projectname + " :- " +pTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=getProjectById(pTime[0].key).projectname.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in f) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return t.feeling == f[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=f[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return d.feeling;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return leaves.length;
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=f[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= expression(ds.key)+" :- "+ Math.round((ds.values/localTimesheets.length)*100) +" Percent";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);

                    }

                    bLeg.cTaskStack= function (categories,mytasks) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in categories){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == categories[i];
                                        });
                                        var pTime= d3.nest()
                                                  .key(function (d) {
                                                            return getTaskById(d.task_id).task_category;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                     //   console.log(pTime[0]);

                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ pTime[0].key.toLowerCase().replace(/ +/g, ""));
                                        ancher.text= pTime[0].key + " :- " +pTime[0].values +" Mins" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=pTime[0].key.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";

                                        var tsk= tasks.filter(function (d) {
                                               return d.task_category == categories[i];
                                        }).map(function (t) {
                                             return t.id;
                                        });
                                   //     console.log(tsk);

                                        for (var cat in tsk) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return t.task_id == tsk[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=tsk[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return d.task_id;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=tsk[cat];
                                                            ds.values= myd[0].values;
                                                  }


                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent=getTaskById(ds.key).taskname+" :- "+ ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                    }
                              legendBarSelector.appendChild(accordion);

                    }
                    bLeg.cDesignationStack= function (d,c) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in c){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == c[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getTaskById(d.task_id).task_category;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/ +/g, ""));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Mins" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in d) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return getUserById(t.user_id).designation == d[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=c[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getUserById(d.user_id).designation;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=d[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key+" :- "+ ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);
                    }
                    bLeg.cFeelingStack= function (c,f) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in c){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == c[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getTaskById(d.task_id).task_category;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return leaves.length;
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/ +/g, ""));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in f) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return t.feeling == f[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=f[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return d.feeling ;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return leaves.length;
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=f[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent=expression(ds.key) +" ~ "+ Math.round((ds.values/localTimesheets.length)*100)  +" Percent";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);

                    }
                    bLeg.cSbuStack=function (c,s) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in c){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getTaskById(t.task_id).task_category == c[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getTaskById(d.task_id).task_category;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/ +/g, ""));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in s) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return getProjectById(t.project_id).sbu == s[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=s[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getProjectById(d.project_id).sbu ;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=s[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key +" ~ "+ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);






                    }

                    bLeg.dCategoryStack=function (d,c) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in d){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == d[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getUserById(d.user_id).designation;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                       //console.log(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                         var pannelHeading= document.createElement('div');
                                         pannelHeading.className="panel-heading"
                                         var pannelHeadingTitle= document.createElement('h4');
                                         pannelHeadingTitle.className= "panel-title";
                                         var ancher= document.createElement('a');
                                         ancher.setAttribute("data-toggle","collapse");
                                         ancher.setAttribute("data-parent","#accordion");
                                         ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, ''));
                                         ancher.text= cTime[0].key + " :- " +cTime[0].values +" Mins" ;
                                         var collapse=document.createElement('div');
                                         collapse.className="panel-collapse collapse";
                                         collapse.id=cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, '');
                                         var pannelBody= document.createElement("div");
                                         pannelBody.className= "panel-body";
                                         var ul= document.createElement('ul');
                                         ul.className="list-group";
                                         for (var cat in c) {
                                                   var localTsheets = localTimesheets.filter(function (t) {
                                                             //console.log(getTaskById(t.task_id).task_category);
                                                             return getTaskById(t.task_id).task_category == c[cat];
                                                   });
                                                   var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=c[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getTaskById(d.task_id).task_category;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=c[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                              //     console.log(localTsheets);

                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key+" :- "+ ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                                legendBarSelector.appendChild(accordion);
                    }
                    bLeg.dFeelingStack =function (d,f) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in d){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == d[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getUserById(d.user_id).designation ;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return leaves.length;
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, ''));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, '');
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in f) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return t.feeling == f[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=f[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return d.feeling ;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return leaves.length;
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=f[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent=expression(ds.key) +" ~ "+ Math.round((ds.values/localTimesheets.length)*100)  +" Percent";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);


                    }
                    bLeg.dSbuStack= function (d,s) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in d){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getUserById(t.user_id).designation == d[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getUserById(d.user_id).designation;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, ''));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, '');
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in s) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return getProjectById(t.project_id).sbu == s[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=s[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getProjectById(d.project_id).sbu ;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=s[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key +" ~ "+ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);

                    }

                    bLeg.sCategoryStack=function (c,s) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in s){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == s[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getProjectById(d.project_id).sbu;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/ +/g, ""));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/ +/g, "");
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in c) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return getTaskById(t.task_id).task_category == c[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=c[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getTaskById(d.task_id).task_category ;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=c[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key +" ~ "+ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);



                    }
                    bLeg.sFeelingStack=function (s,f) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in s){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == s[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getProjectById(d.project_id).sbu ;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return leaves.length;
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, ''));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, '');
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in f) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return t.feeling == f[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=f[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return d.feeling ;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return leaves.length;
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=f[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent=expression(ds.key) +" ~ "+ Math.round((ds.values/localTimesheets.length)*100)  +" Percent";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);



                    }
                    bLeg.sDesignationStack=function (d,s) {
                              var legendbar=d3.select("#barlegend");
                              var legendBarSelector= document.getElementById("barlegend");
                              legendbar.select("#accordion").remove();
                              legendbar.select("ul").remove();
                              var accordion= document.createElement("div");
                              accordion.id= "accordion";
                              accordion.className= "panel-group";
                              for (i in s){
                                        var localTimesheets= timesheets.filter(function (t) {
                                                  return getProjectById(t.project_id).sbu == s[i];
                                        });
                                        var cTime= d3.nest()
                                                  .key(function (d) {
                                                            return getProjectById(d.project_id).sbu;
                                                  })
                                                  .rollup(function (leaves) {
                                                            return d3.sum(leaves, function (d) {
                                                                      return parseInt(d.timespent);
                                                            })
                                                  })
                                                  .entries(localTimesheets);
                                        var pannel= document.createElement('div');
                                        pannel.className="panel panel-default";
                                        var pannelHeading= document.createElement('div');
                                        pannelHeading.className="panel-heading"
                                        var pannelHeadingTitle= document.createElement('h4');
                                        pannelHeadingTitle.className= "panel-title";
                                        var ancher= document.createElement('a');
                                        ancher.setAttribute("data-toggle","collapse");
                                        ancher.setAttribute("data-parent","#accordion");
                                        ancher.setAttribute("href","#"+ cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, ''));
                                        ancher.text= cTime[0].key + " :- " +cTime[0].values +" Timesheets" ;
                                        var collapse=document.createElement('div');
                                        collapse.className="panel-collapse collapse";
                                        collapse.id=cTime[0].key.toLowerCase().replace(/["~!@#$%^&*\(\)_+=`{}\[\]\|\\:;'<>,.\/?"\- \t\r\n]+/g, '');
                                        var pannelBody= document.createElement("div");
                                        pannelBody.className= "panel-body";
                                        var ul= document.createElement('ul');
                                        ul.className="list-group";
                                        for (var cat in d) {
                                                  var localTsheets = localTimesheets.filter(function (t) {
                                                            return getUserById(t.user_id).designation == d[cat];
                                                  });
                                                  var ds= new Object();
                                                  if (localTsheets.length<=0){
                                                            ds.key=d[cat];
                                                            ds.values= 0;
                                                  }else {
                                                            var myd= d3.nest()
                                                                      .key(function (d) {
                                                                                return getUserById(d.user_id).designation ;
                                                                      })
                                                                      .rollup(function (leaves) {
                                                                                return d3.sum(leaves, function (d) {
                                                                                          return parseInt(d.timespent);
                                                                                })
                                                                      })
                                                                      .entries(localTsheets);
                                                            ds.key=d[cat];
                                                            ds.values= myd[0].values;
                                                  }
                                                  var li= document.createElement("li");
                                                  li.className="list-group-item";
                                                  li.textContent= ds.key +" ~ "+ds.values +" Mins";
                                                  li.style="background:"+ COLOR(cat);
                                                  ul.appendChild(li);
                                        }
                                        pannelHeadingTitle.appendChild(ancher);
                                        pannelHeading.appendChild(pannelHeadingTitle);
                                        pannelBody.appendChild(ul);
                                        collapse.appendChild(pannelBody);
                                        pannel.appendChild(pannelHeading);
                                        pannel.appendChild(collapse);
                                        accordion.appendChild(pannel);
                              }
                              legendBarSelector.appendChild(accordion);

                    }

                    return bLeg;

          }

}
