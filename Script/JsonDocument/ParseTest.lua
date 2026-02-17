--[[
Author: xixi_
Date: 2026-02-17 18:02:30
LastEditors: xixi_
LastEditTime: 2026-02-17 18:02:34
FilePath: /MiniWorldScript/Script/JsonDocument/Json1.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

local JsonDocument = require("JsonDocument");

local JsonString = [=[
  {
    "Data": {
      "article": {
        "title": "文章",
        "searchType": 1,
        "data": [{
          "article_id": 10496,
          "title": "做好防范，让baby不再坠床",
          "content": "",
          "author": "为宝宝加营养",
          "business_brand_name": null,
          "reads": 0,
          "is_top": 0,
          "is_hot": 0,
          "is_discuss": 0,
          "is_red": 0,
          "user_id": 1020,
          "user_name": "马瑞",
          "sort_no": 99,
          "articletype_id": 0,
          "articletype": {
            "articletype_id": 1002,
            "typename": "日常生活",
            "fid": 0
          },
          "image_id": null,
          "image": {
            "file_id": 15648,
            "path": "http://xxxx.jpg",
            "grade_code": "7f631ed8-0c80-4e91-8b4a-c",
            "sort_no": 99,
            "filetype_name": "pictext"
          },
          "grade_code": "",
          "imageList": [],
          "keydes": "",
          "photo": null,
          "iscollect": 0,
          "utime": "2018-09-19T16:00:08.447",
          "likecount": 0,
          "commentlist": null,
          "statusName": "auditSuccess",
          "contentType": 1
        }]
      },
      "video": {
        "title": "视频",
        "searchType": 2,
        "data": [{
          "courses_id": 1059,
          "title": "妈咪宝贝护理",
          "content": "讲述孕期妈咪们、0-1岁宝宝的护理内容，并列出解决方案，全真人出演，专业护士操作指导，让用户更有代入感。",
          "price": 0,
          "author": "留心脚下",
          "purchaseNotes": "虚拟商品不退不换，敬请谅解",
          "is_top": 0,
          "is_hot": 1,
          "is_red": 0,
          "is_discuss": 0,
          "is_concentration": 1,
          "user": {
            "userdtl": null,
            "coachUser": null,
            "businessUser": null,
            "user_id": 1146,
            "phone": "13648953657",
            "name": "留心脚下",
            "token": "3C76F191825EF5302BBC10609A903C77",
            "is_enable": 1,
            "ctime": "2018-09-03T20:04:54.153",
            "utime": "2018-09-03T20:04:54.153",
            "grade": {
              "grade_id": 1008,
              "grade_name": "家庭教练用户",
              "sort_no": 99,
              "ctime": "2018-07-04T10:59:22.067",
              "utime": "2018-07-04T10:59:22.067",
              "description": null,
              "userRole": [
                "coach-ordinary"
              ],
              "userType": "coachUser",
              "alias": "coach-ordinary",
              "perssions": null,
              "isUsed": false,
              "userCount": 0
            },
            "userType": "coachUser",
            "isFollow": 0,
            "image": {
              "file_id": 13293,
              "path": "http://xxxx.jpg",
              "grade_code": "",
              "sort_no": 99,
              "filetype_name": "pictext"
            },
            "resume": "宝贝需要护理，妈妈同样需要哦，快来了解吧",
            "nikeName": "留心脚下",
            "label": "妈咪宝贝护理"
          },
          "image": {
            "file_id": 14899,
            "path": "http://xxxxx.png",
            "grade_code": "6bddbf33-1c75-4fca-8195-9f41540fc8b7",
            "sort_no": 99,
            "filetype_name": "pictext"
          },
          "imageList": [],
          "sort_no": 99,
          "ctime": "2018-09-10T16:34:34.983",
          "utime": "2018-09-10T16:34:34.997",
          "keydes": "",
          "article_source": "原创",
          "coursesType": 2,
          "classify_id": 0,
          "classify": {
            "classify_id": 1005,
            "fid": 1002,
            "classifys": null,
            "classifyName": "生长发育",
            "ctime": "2018-06-29T10:42:34",
            "sort_no": 1,
            "classifyType": 2,
            "isUsed": false
          },
          "practicalPeople": "0-1岁",
          "totalNumber": 0,
          "studyNumber": 3,
          "vip_label": 0,
          "integral": 0,
          "discount": 1,
          "consumptionType": "free",
          "consumptionDetails": [],
          "score": 2.5,
          "isPurchase": 0,
          "isScore": 0,
          "comments": null,
          "progressShow": null,
          "isCollect": 0,
          "statusName": "1",
          "fcModuleType": 0
        }]
      },
      "audio": {
        "title": "音频",
        "searchType": 3,
        "data": [{
          "courses_id": 1068,
          "title": "英文儿歌",
          "content": "朗朗上口，合辙押韵，短小精悍，便于宝宝记忆，宝宝一学就会，增强了宝宝的自信心，锻炼了宝宝的记忆力与学习英语能力。",
          "price": 0,
          "author": "咿咿呀呀在唱歌",
          "purchaseNotes": "虚拟商品不退不换，敬请谅解",
          "is_top": 0,
          "is_hot": 1,
          "is_red": 0,
          "is_discuss": 0,
          "is_concentration": 1,
          "user": {
            "userdtl": null,
            "coachUser": null,
            "businessUser": null,
            "user_id": 1150,
            "phone": "13523478965",
            "name": "咿咿呀呀在唱歌",
            "token": "4F97A2CABFE986B370066730142653CE",
            "is_enable": 1,
            "ctime": "2018-09-03T20:11:53.227",
            "utime": "2018-09-03T20:11:53.227",
            "grade": {
              "grade_id": 1008,
              "grade_name": "家庭教练用户",
              "sort_no": 99,
              "ctime": "2018-07-04T10:59:22.067",
              "utime": "2018-07-04T10:59:22.067",
              "description": null,
              "userRole": [
                "coach-ordinary"
              ],
              "userType": "coachUser",
              "alias": "coach-ordinary",
              "perssions": null,
              "isUsed": false,
              "userCount": 0
            },
            "userType": "coachUser",
            "isFollow": 0,
            "image": {
              "file_id": 13297,
              "path": "http://xxxxxx.jpg",
              "grade_code": "",
              "sort_no": 99,
              "filetype_name": "pictext"
            },
            "resume": "在歌曲中学习语言，你会发现有不一样的收获",
            "nikeName": "咿咿呀呀在唱歌",
            "label": "学语儿歌"
          },
          "image": {
            "file_id": 8830,
            "path": "http://xxxx.jpg",
            "grade_code": "",
            "sort_no": 99,
            "filetype_name": "pictext"
          },
          "imageList": [],
          "sort_no": 99,
          "ctime": "2018-08-21T23:39:20.967",
          "utime": "2018-08-21T23:39:20.977",
          "keydes": "",
          "article_source": "原创",
          "coursesType": 3,
          "classify_id": 0,
          "classify": {
            "classify_id": 1016,
            "fid": 1000,
            "classifys": null,
            "classifyName": "儿歌",
            "ctime": "2018-08-07T00:00:00",
            "sort_no": 2,
            "classifyType": 3,
            "isUsed": false
          },
          "practicalPeople": "0-6岁",
          "totalNumber": 0,
          "studyNumber": 1,
          "vip_label": 0,
          "integral": 0,
          "discount": 1,
          "consumptionType": "free",
          "consumptionDetails": [],
          "score": 0,
          "isPurchase": 0,
          "isScore": 0,
          "comments": null,
          "progressShow": null,
          "isCollect": 0,
          "statusName": "1",
          "fcModuleType": 0
        }]
      },
      "activity": {
        "title": "活动",
        "searchType": 4,
        "data": [{
          "article_id": 1053,
          "title": "XXXX.株洲荷塘店 | \"绘本\",“沙滩接力跑”亲子沙龙报名开始啦",
          "content": "",
          "author": null,
          "business_brand_name": null,
          "reads": 0,
          "is_top": 0,
          "is_hot": 0,
          "is_discuss": 0,
          "is_red": 0,
          "user_id": null,
          "user_name": null,
          "sort_no": 80,
          "articletype_id": 0,
          "articletype": null,
          "image_id": null,
          "image": {
            "file_id": 10449,
            "path": "http://xxxx.jpg",
            "grade_code": "",
            "sort_no": 99,
            "filetype_name": "pictext"
          },
          "grade_code": "",
          "imageList": [],
          "keydes": null,
          "photo": null,
          "iscollect": 0,
          "utime": "0001-01-01T00:00:00",
          "likecount": 0,
          "commentlist": null,
          "statusName": null,
          "contentType": 0
        }]
      },
      "book": {
        "title": "绘本",
        "searchType": 5,
        "data": [{
          "content_id": 1582,
          "title": "爱的摇篮曲",
          "summarize": "夜晚，妈妈在床边轻声哄着小宝贝睡觉，可是小宝贝不肯睡。怎样能让宝宝入睡呢？",
          "image": {
            "file_id": 10415,
            "path": "http://xxxx.png",
            "grade_code": "",
            "sort_no": 99,
            "filetype_name": "pictext"
          },
          "ageGroupStart": 3,
          "ageGroupEnd": 3
        }]
      },
      "toy": {
        "title": "玩教具",
        "searchType": 6,
        "data": [{
          "content_id": 1629,
          "title": "赶小猪",
          "summarize": "长短适中的小棍一根，小篮球或小皮球1个。在宽阔的户外或家庭中，妈妈在地上画根线或者一个圆圈表示小猪的家，让宝宝用小棍把篮球小猪赶回家。",
          "image": {
            "file_id": 10805,
            "path": "http://xxxx.jpg",
            "grade_code": "",
            "sort_no": 99,
            "filetype_name": "pictext"
          },
          "ageGroupStart": 5,
          "ageGroupEnd": 6
        }]
      }
    }
  }
]=]


local start_time = os.clock() -- 记录开始时间

local Obj = JsonDocument.Decode(JsonString);
print(Obj.Data.activity.title)
print(JsonDocument.Encode(Obj));

local end_time = os.clock()                -- 记录结束时间
local elapsed_time = end_time - start_time -- 计算耗时

print("Elapsed time: " .. elapsed_time .. " seconds")
