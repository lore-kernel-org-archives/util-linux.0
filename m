Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD7C433EF
	for <util-linux@archiver.kernel.org>; Mon, 18 Jul 2022 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiGRNa4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiGRNa4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2022 09:30:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5933A2
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2022 06:30:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 286131FACC
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2022 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658151054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=eLU8Sv2vGnIWmPV/nQMNrOTIhK6lF7WYJ8RbIeh8u4I=;
        b=GkH9G3XDDR8BCkSn575HvD+RIa6PiDrojcHqwCF2/s9TiPZSbYTfT3X/SzGuLLEdZya+gD
        gpG9xGpiTe4YphHSaS1VylB1LJ4O6E/b+ukp7PkxHy0RRnLdxYNDZpkq0X6RUg9vm8rxNB
        mneISv2k3gj1KkCVAuKXue3NZQR8ZYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658151054;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=eLU8Sv2vGnIWmPV/nQMNrOTIhK6lF7WYJ8RbIeh8u4I=;
        b=q1EQayZ3UegK7Nq8mR8yFtJ5iD1basOQTvogGRv29noxfmwQl2EAcNOgM8oDGqCUK41bjr
        WdaLYjXb5rEgVuCg==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 22CFB2C141
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2022 13:30:54 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 9500F444B2F; Mon, 18 Jul 2022 15:30:53 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     util-linux@vger.kernel.org
Subject: <linux/fs.h> conflicts with <sys/mount.h>
X-Yow:  ..  I don't understand the HUMOR of the THREE STOOGES!!
Date:   Mon, 18 Jul 2022 15:30:53 +0200
Message-ID: <mvm35eyh7jm.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

With the upcoming glibc 2.36, <linux/fs.h> conflicts with <sys/mount.h>:

In file included from /usr/include/linux/fs.h:19,
                 from login-utils/sulogin-consoles.c:46:
/usr/include/linux/mount.h:95:6: error: redeclaration of 'enum fsconfig_command'
   95 | enum fsconfig_command {
      |      ^~~~~~~~~~~~~~~~
In file included from login-utils/sulogin-consoles.c:45:
/usr/include/sys/mount.h:189:6: note: originally defined here
  189 | enum fsconfig_command
      |      ^~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:96:9: error: redeclaration of enumerator 'FSCONFIG_SET_FLAG'
   96 |         FSCONFIG_SET_FLAG       = 0,    /* Set parameter, supplying no value */
      |         ^~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:191:3: note: previous definition of 'FSCONFIG_SET_FLAG' with type 'enum fsconfig_command'
  191 |   FSCONFIG_SET_FLAG       = 0,    /* Set parameter, supplying no value */
      |   ^~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:97:9: error: redeclaration of enumerator 'FSCONFIG_SET_STRING'
   97 |         FSCONFIG_SET_STRING     = 1,    /* Set parameter, supplying a string value */
      |         ^~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:193:3: note: previous definition of 'FSCONFIG_SET_STRING' with type 'enum fsconfig_command'
  193 |   FSCONFIG_SET_STRING     = 1,    /* Set parameter, supplying a string value */
      |   ^~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:98:9: error: redeclaration of enumerator 'FSCONFIG_SET_BINARY'
   98 |         FSCONFIG_SET_BINARY     = 2,    /* Set parameter, supplying a binary blob value */
      |         ^~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:195:3: note: previous definition of 'FSCONFIG_SET_BINARY' with type 'enum fsconfig_command'
  195 |   FSCONFIG_SET_BINARY     = 2,    /* Set parameter, supplying a binary blob value */
      |   ^~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:99:9: error: redeclaration of enumerator 'FSCONFIG_SET_PATH'
   99 |         FSCONFIG_SET_PATH       = 3,    /* Set parameter, supplying an object by path */
      |         ^~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:197:3: note: previous definition of 'FSCONFIG_SET_PATH' with type 'enum fsconfig_command'
  197 |   FSCONFIG_SET_PATH       = 3,    /* Set parameter, supplying an object by path */
      |   ^~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:100:9: error: redeclaration of enumerator 'FSCONFIG_SET_PATH_EMPTY'
  100 |         FSCONFIG_SET_PATH_EMPTY = 4,    /* Set parameter, supplying an object by (empty) path */
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:199:3: note: previous definition of 'FSCONFIG_SET_PATH_EMPTY' with type 'enum fsconfig_command'
  199 |   FSCONFIG_SET_PATH_EMPTY = 4,    /* Set parameter, supplying an object by (empty) path */
      |   ^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:101:9: error: redeclaration of enumerator 'FSCONFIG_SET_FD'
  101 |         FSCONFIG_SET_FD         = 5,    /* Set parameter, supplying an object by fd */
      |         ^~~~~~~~~~~~~~~
/usr/include/sys/mount.h:201:3: note: previous definition of 'FSCONFIG_SET_FD' with type 'enum fsconfig_command'
  201 |   FSCONFIG_SET_FD         = 5,    /* Set parameter, supplying an object by fd */
      |   ^~~~~~~~~~~~~~~
/usr/include/linux/mount.h:102:9: error: redeclaration of enumerator 'FSCONFIG_CMD_CREATE'
  102 |         FSCONFIG_CMD_CREATE     = 6,    /* Invoke superblock creation */
      |         ^~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:203:3: note: previous definition of 'FSCONFIG_CMD_CREATE' with type 'enum fsconfig_command'
  203 |   FSCONFIG_CMD_CREATE     = 6,    /* Invoke superblock creation */
      |   ^~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:103:9: error: redeclaration of enumerator 'FSCONFIG_CMD_RECONFIGURE'
  103 |         FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock reconfiguration */
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:205:3: note: previous definition of 'FSCONFIG_CMD_RECONFIGURE' with type 'enum fsconfig_command'
  205 |   FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock reconfiguration */
      |   ^~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:129:8: error: redefinition of 'struct mount_attr'
  129 | struct mount_attr {
      |        ^~~~~~~~~~
/usr/include/sys/mount.h:161:8: note: originally defined here
  161 | struct mount_attr
      |        ^~~~~~~~~~
make[2]: *** [Makefile:9597: login-utils/sulogin-consoles.o] Error 1

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
