Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:48106 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbaDQIeK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 17 Apr 2014 04:34:10 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so133510wgh.24
        for <util-linux@vger.kernel.org>; Thu, 17 Apr 2014 01:34:09 -0700 (PDT)
Received: from [172.16.3.2] (91-64-36-142-dynip.superkabel.de. [91.64.36.142])
        by mx.google.com with ESMTPSA id n5sm3504048wiz.1.2014.04.17.01.34.07
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Apr 2014 01:34:07 -0700 (PDT)
Message-ID: <534F91FD.4020803@ezeep.com>
Date: Thu, 17 Apr 2014 10:34:05 +0200
From: Nicolas <nicolas.delaby@ezeep.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: nsenter: passing command arguments
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
I'm struggling with nsenter to call commands with options because they 
are caught by nsenter and complain this is an invalid option.

How can I pass any arbitrary argument ?

Thanks for reading,
Nicolas

```
$ nsenter --target $PID --mount --uts --ipc --net --pid ls -a
nsenter: invalid option -- 'a'

Usage:
  nsenter [options] <program> [args...]

Options:
  -t, --target <pid>     target process to get namespaces from
  -m, --mount [=<file>]  enter mount namespace
  -u, --uts   [=<file>]  enter UTS namespace (hostname etc)
  -i, --ipc   [=<file>]  enter System V IPC namespace
  -n, --net   [=<file>]  enter network namespace
  -p, --pid   [=<file>]  enter pid namespace
  -U, --user  [=<file>]  enter user namespace
  -S, --setuid <uid>     set uid in user namespace
  -G, --setgid <gid>     set gid in user namespace
  -r, --root  [=<dir>]   set the root directory
  -w, --wd    [=<dir>]   set the working directory
  -F, --no-fork          do not fork before exec'ing <program>

  -h, --help     display this help and exit
  -V, --version  output version information and exit

For more details see nsenter(1).

```

-- 

Nicolas Delaby · Software Engineer · ezeep.com

ezeep GmbH · Ohlauer Str. 43 · 10999 Berlin · Germany

Registry Court: Charlottenburg · HRB133318 · Managing partner: Sascha 
Kellert
