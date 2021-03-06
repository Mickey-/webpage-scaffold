###
 grunt-webpage-scaffold
 https://github.com/Mickey-/webpage-scaffold

 Copyright (c) 2014 Mickey-
 Licensed under the MIT license.
###

'use strict'

module.exports = (g) ->

  g.registerTask('webpage', 'Help build the new Webpage project, static resource automatic generation of page demo file and dependence (optional without JS file). Once to initialize grunt, open the default browser to observe the compiled Demo. At the same time will automatically start the Livereload pattern of development, we can start coding: )', () ->
    require('colors')
    open = require('open')
    done = @async()

    #默认配置，会被gruntfile覆盖
    opt = this.options(
      coffee: ''
      js: 'js/page/'
      less: 'less/page/'
      lessCommonCode: ''
      demo: 'demos/'
      demoShowPath: './build/demos/'
      tplPath: '.tpl'
    )

    #新模块名，如果叫xxx，则grunt webpage_scaffold:xxx
    pageName = this.args[0]
    #是否不需要引入js，如果不需要js，则grunt webpage_scaffold:xxx:true
    ifNotNeedJs = this.args[1]
    if !pageName
      g.fail.warn('请指定新项目模块名称,如： ' + 'grunt init:modname'.inverse + '。注意默认会在新demo文件' + 'modname.html'.underline + '里引入' + 'modname.js'.cyan + '和' + 'modname.css'.cyan)

    tplBuffer = g.file.read(opt.tplPath)
    tplBuffer = tplBuffer.replace(/#{pagename}/g, pageName)
    write = g.file.write
    styleType = 'less'
    scriptType = if opt.coffee then 'coffee' else 'js'

    #默认内容
    files = [
      dest: opt.demo + pageName + '.html'
      content: tplBuffer
    ,
      dest: opt[styleType] + pageName + '.' + styleType
      content: opt.lessCommonCode + '\r\n.' + pageName + ' {\r\n\r\n}'
    ,
      dest: opt[scriptType] + pageName + '.' + scriptType
      content: '"use strict";\r\n'
      #新模块是否需要js逻辑
      ifNotNeedJs: ifNotNeedJs
    ]

    #写文件
    files.forEach((v, k) ->
      if v.ifNotNeedJs == undefined || !v.ifNotNeedJs
        if write(v.dest, v.content)
          g.log.ok(v.dest + '生成成功！')
        else
          writeError()
    )

    gruntIns = g.log.write('\n模块' + pageName.cyan + '构建中...')
    sc = g.util.spawn(
      cmd: 'grunt'
      ,(err, ret, code) ->
        if !err
          gruntIns.ok()
          console.log('\n进入开发模式'.yellow)
          g.task.run(['watch'])
          open(opt.demoShowPath + pageName + '.html')
          done(true)
    )

    writeError = (msg) ->
      g.log.error(msg || '文件写入失败！')
  )
