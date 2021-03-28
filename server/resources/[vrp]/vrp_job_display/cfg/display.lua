
-- return cfg

local cfg = {}

cfg.firstjob = "Arbejdsløs" -- set this to your first job, for example "citizen", or false to disable

-- text display css
cfg.display_css = [[
@font-face {
  font-family: 'hyperion';
  src: url('https://byhyperion.net/stylesheet/fonts/american_captain.ttf');
}

.div_job{
  position: absolute;
  top: 30px;
  left: 40px;
  letter-spacing: 1.5px;
  font-size: 29px;
  font-weight: bold;
  color: white;
  text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;
  font-family: "hyperion";
}
]]

-- icon display css
cfg.icon_display_css = [[
.div_job_icon{
  position: absolute;
  height: 3%;
  width: 2%;
  bottom: 0.2%;
  left: 15.6%;
}
]]

-- list of ["group"] => css for icons
cfg.group_icons = {
  ["Politi-Job"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/politi.png);
    }
  ]],
  ["handvarker"] = [[
    .div_job_icon{
      content: url(https://cdn.khRamlovOgHoej.com/attachments/585086641165565963/651127967996444725/handvarker.png);
    }
  ]],
  ["Quarry Transporter"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/lastbilchauffoer.png);
    }
  ]],
  ["Elev"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/politi.png);
    }
  ]],
  ["AKS"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/politi.png);
    }
  ]],
  ["Ambulanceredder"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/ems.png);
    }
  ]],
    ["EMS-Job"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/ems.png);
    }
  ]],
    ["EMS-Jobelev"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/ems.png);
    }
  ]],
  ["Mekaniker"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/mekaniker.png);
    }
  ]],
  ["Taxi"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/taxi.png);
    }
  ]],
  ["Træhugger"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/traehugger.png);
    }
  ]],
  ["Advokat"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/advokat.png);
    }
  ]],
    ["Journalist-Job"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/journalist.png);
    }
  ]],
  ["Dommer"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/dommer.png);
    }
  ]],
    ["Bilforhandler"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/bilforhandler.png);
    }
  ]],
  ["Arbejdsløs"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/civil.png);
    }
  ]],
  ["Biltyv"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/kriminel/biltyv.png);
    }
  ]],
  ["Udbringer"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/udbringer.png);
    }
  ]],
  ["Postbud"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/postbud.png);
    }
  ]],
  ["Skraldemand"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/skraldemand.png);
    }
  ]],
  ["The Lost"] = [[
    .div_job_icon{
      content: url(https://imgur.com/2iMA2Ys.png);
    }
  ]],
  ["Colombo"] = [[
    .div_job_icon{
      content: url(https://imgur.com/2iMA2Ys.png);
    }
  ]],
  ["Lastbilchauffør"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/lastbilchauffoer.png);
    }
  ]],
  ["Pengetransport"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/pengetransport.png);
    }
  ]],
  ["Miner"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/minearbejder.png);
    }
  ]],
    ["Ejendom"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/ejendom.png);
    }
  ]],
      ["Pilot"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/pilot.png);
    }
  ]],
  ["PET-agent"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/politi.png);
    }
  ]],
  ["Psykolog"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/psykolog.png);
    }
  ]],
    ["Drugdealer"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/kriminel/drugdealer.png);
    }
  ]],
      ["Kriminel"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/kriminel/kriminel.png);
    }
  ]],
  ["Mafia"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/kriminel/kriminel.png);
    }
  ]],
  ["MS-13"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/kriminel/kriminel.png);
    }
  ]],
  ["Våbenhandler"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/kriminel/kriminel.png);
    }
  ]],
  ["Kartellet"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/kriminel/kriminel.png);
    }
  ]],
  ["Fisker"] = [[
    .div_job_icon{
      content: url(http://sky-universe.dk/5mimages/job_display/lovlig/fisker.png);
    }
  ]], -- this is an example, add more under it using the same model, leave the } at the end.
}
return cfg