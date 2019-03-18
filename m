Return-Path: <SRS0=Nyt8=RV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A0EC43381
	for <util-linux@archiver.kernel.org>; Mon, 18 Mar 2019 12:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788E220857
	for <util-linux@archiver.kernel.org>; Mon, 18 Mar 2019 12:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCRMx1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfCRMx0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Mar 2019 08:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D957307D861;
        Mon, 18 Mar 2019 12:53:26 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFDA05D707;
        Mon, 18 Mar 2019 12:53:24 +0000 (UTC)
Date:   Mon, 18 Mar 2019 13:53:22 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Rick van Rein <rick@openfortress.nl>,
        =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <asbjorn@asbjorn.st>
Subject: script(1) plans
Message-ID: <20190318125322.4obb27vwtxfuwuie@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 18 Mar 2019 12:53:26 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Hi all,

I'd like to improve script(1) to be more flexible and support more
streams. The current version allow to log only output, but I'd like to
add possibility to log input, signals and more details about the
session.

The idea is to introduce a new timing file format; and use it in case
a new features are requested by user on script(1) command line. The
new format will be still based on text and easy to convert to the old
version.

* New options:

 --log-out <file>	    log output to <file>
 --log-in <file>        log input to <file>
 --log-io <file>        log both input and output to <file>
 --log-timing <file>    timing file (alias to --timing[=<file>])
 --no-signal            don't log signals

The all --log-* options enables the new format, otherwise old format is used.

 script --timing[=<file>] <file>              := old timing file format

 script --log-timing <file> --log-out <file>  := new format

Note that the current --timing uses optional argument and the default
is log timing information to the stderr. This crazy feature will be
deprecated and unsupported for the new --log-timing <file>.


* Another new feature is --json (mutually exclusive to --log-timing), in this
case log data and timing information will be merged together:

 {
    "version":"2.33.1",
    "term":"xterm",
	
    "log": [
      { "type":"in",  "delta":1.930626, "data":"ls" },
      { "type":"out", "delta":0.123356, "data":"some crazy data" },
      { "type":"sig", "delta":0.500000, "name":"SIGWINCH", "columns":50, "lines":20 },
      ...
    ]
 }


* logs redirection (pipe) to another commands:

 --log-out-cmd <cmd>
 --log-in-cmd <cmd>
 --log-io-cmd <cmd>

The redirection will be possible to use with --json too.


* The new (multi-stream) timing file format:

    <type> <timestamp> [<offset> | <signal> ...]

     # comment
     H NAME=<value>
     H ...
     O 0.001296 256
     S 0.001297 SIGWINCH: columns=50, lines=20
     I 0.000010 10

 H : header (VERSION=, TERM=, STARTTIME=, EXITCODE=, COLUMNS=, LINES=, COMMAND= ...)
 O : output
 I : input
 S : signal

 Conversion to the old version:

	awk '/^O / { print $2" "$3 }'

		
* scriptreplay(1) will be extended to autodetect and support the new format and
  print summary about the session, new options:

  --summary       print details from headers (like TERM=, ...)
  --play-input    print input only
  --play-output   (default)
  

* new command scriptlive(1)

 - create a new session (slave/master pty) with shell/command to repeat previously
   recorded session on a real shell/command.

 - for example you can record session (with --log-in) on one machine, repeat 
   later on another machine(s)


The target release will be probably v2.35 and I'm going to start work
on it ASAP (probably this or next week).

Comments & objections?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
