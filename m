Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BC4C433F5
	for <util-linux@archiver.kernel.org>; Thu, 24 Mar 2022 00:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbiCXA2s (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Mar 2022 20:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiCXA2r (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Mar 2022 20:28:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E07D015
        for <util-linux@vger.kernel.org>; Wed, 23 Mar 2022 17:27:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A41DF210F0
        for <util-linux@vger.kernel.org>; Thu, 24 Mar 2022 00:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648081635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Aw8OP8BG2C51u1skFNir52Nid13hId7QkBWnuy2i2MY=;
        b=q/UL4j7uzZY5lTRiA32ix8Yn44MSVfzhtKolDIWf6uZGYgiBQKasBvu3GRc7x95zrn7eNo
        ExNErCcuNj7hqPgoS5oXii65az647ZMVn3TygsLTfAbgU8JaHb/meYQCSDV/p2BjZ47m5Q
        MP09B3oC9qhNkSQpevJHt5P/2TSMjAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648081635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Aw8OP8BG2C51u1skFNir52Nid13hId7QkBWnuy2i2MY=;
        b=3oF9LgQ5XyzJiiCThDgf4OrixA4ktsbhJWhSw2ceVujZ0FZ2OxHhmJexu3TTIJXtDNlSRz
        WlTTfGndoY62xfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9426612FC5
        for <util-linux@vger.kernel.org>; Thu, 24 Mar 2022 00:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gALjIuO6O2I/MgAAMHmgww
        (envelope-from <sbrabec@suse.cz>)
        for <util-linux@vger.kernel.org>; Thu, 24 Mar 2022 00:27:15 +0000
Message-ID: <aeb70bf3-cda5-a3a2-9b38-156c79d39b0b@suse.cz>
Date:   Thu, 24 Mar 2022 01:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     util-linux@vger.kernel.org
Content-Language: en-US
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] flock(1): Decribe limitations of flock: deadlock, NFS, CIFS
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The flock(1) does not refer to limitations of flock(2). Provide an
documentation entry point for solving of problems with flock on NFS
and CIFS and mention risk of deadlock.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
  sys-utils/flock.1.adoc | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/sys-utils/flock.1.adoc b/sys-utils/flock.1.adoc
index c645a60f6..d5b4f10aa 100644
--- a/sys-utils/flock.1.adoc
+++ b/sys-utils/flock.1.adoc
@@ -91,6 +91,12 @@ The command uses <sysexits.h> exit status values for everything, except when usi
  
  When using the _command_ variant, and executing the child worked, then the exit status is that of the child command.
  
+== NOTES
+
+*flock* does not detect deadlock. See *flock*(2) for details.
+
+Some file systems (e. g. NFS and CIFS) have a limited implementation of *flock*(2) and flock may always fail. For details see *flock*(2), *nfs*(5) and *mount.cifs*(8). Depending on mount options, flock can always fail there.
+
  == EXAMPLES
  
  Note that "shell> " in examples is a command line prompt.
-- 
2.35.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
