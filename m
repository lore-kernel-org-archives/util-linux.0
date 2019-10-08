Return-Path: <SRS0=y1GS=YB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B15C10F14
	for <util-linux@archiver.kernel.org>; Tue,  8 Oct 2019 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF06206B6
	for <util-linux@archiver.kernel.org>; Tue,  8 Oct 2019 12:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfJHMow (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:44:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730888AbfJHMow (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 8 Oct 2019 08:44:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECBE0300D20F
        for <util-linux@vger.kernel.org>; Tue,  8 Oct 2019 12:44:51 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B38D19C69
        for <util-linux@vger.kernel.org>; Tue,  8 Oct 2019 12:44:51 +0000 (UTC)
Date:   Tue, 8 Oct 2019 14:44:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: script(1), scriptreplay(1) and scriptlive(1)
Message-ID: <20191008124448.4ncaccjshxx4vjov@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 08 Oct 2019 12:44:51 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi all,

 (as promised months ago) we have a new implementation of the script
 stuff now. Details:

 * script(1) is able to record stdout, stdin or both streams

 * new "advanced" timing file format is supported; the file contains
   also information about signals and additional information about the
   session.
 
 * scriptreplay(1) supports all the streams and --summary to print
   overview about the session

 * scriptlive(1) -- new command to re-execute stdin log by shell in
   pseudo-terminal

 * all the tools supports new options --log-in, --log-out, --log-io
   and --log-timing. The original options works too.

 * all changes are backwardly compatible and the new timing file
   format is not enabled by default (you need implicit --logging-format or
   --log-in).

 * yes, script --log-in records all input, including passwords,
   control chars, etc and scriptlive(1) can use it. For example ssh to
   another machine etc.

 Example (see difference between scriptreplay and scriptlive):

 $ script --log-io oi --log-timing tm
 Script started, output log file is 'oi', input log file is 'oi', timing file is 'tm'.
 $ date +'%s'
 1570537455
 $ exit
 Script done.

 $ scriptreplay --summary tm
 START_TIME:  2019-10-08 14:39:49+02:00
       TERM:  xterm-256color
        TTY:  /dev/pts/2
    COLUMNS:  190
      LINES:  50
      SHELL:  /bin/bash
 TIMING_LOG:  tm
 OUTPUT_LOG:  oi
  INPUT_LOG:  oi
   DURATION:  9.229837
  EXIT_CODE:  0

 $ scriptreplay --log-io oi --log-timing tm
 $ date +'%s'
 1570537455
 $ exit


 $ scriptlive --log-io oi --log-timing tm
 >>> scriptlive: Starting your typescript execution by /bin/bash.
 $ date +'%s'
 1570537492
 $ exit 
 >>> scriptlive: done.


    Karel 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
