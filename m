Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E316C433EF
	for <util-linux@archiver.kernel.org>; Mon,  2 May 2022 10:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384622AbiEBKti (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 2 May 2022 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384731AbiEBKtc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 2 May 2022 06:49:32 -0400
X-Greylist: delayed 569 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 03:45:48 PDT
Received: from mx4.uni-regensburg.de (mx4.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:4:4e7a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303C19023
        for <util-linux@vger.kernel.org>; Mon,  2 May 2022 03:45:46 -0700 (PDT)
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 8E8096000052
        for <util-linux@vger.kernel.org>; Mon,  2 May 2022 12:36:11 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 780BB600004F
        for <util-linux@vger.kernel.org>; Mon,  2 May 2022 12:36:11 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 02 May 2022 12:36:11 +0200
Message-Id: <626FB419020000A100049B7A@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.0 
Date:   Mon, 02 May 2022 12:36:09 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <util-linux@vger.kernel.org>
Subject: logger: invalid structured data parameter: 'fo\o="b\"a\"r"'
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi!

Testing my syslogd that was extended to handle RFC 5424 type messages, I found
out that

--sd-param 'fo\o="bar"'

would work, but

--sd-param 'fo\o="b\"a\"r"'

won't. Reading RFC 5424, I guess that using \" in PARAM-VALUE is OK (passing a
literal "):

On page 16, 6.3.3.:
   Inside PARAM-VALUE, the characters ’"’ (ABNF %d34), ’\’ (ABNF %d92),
   and ’]’ (ABNF %d93) MUST be escaped.  This is necessary to avoid
   parsing errors.

So I guess if " miust be escaped, it's allowed to be escaped (to pass a
literal ").

Found in util-linux-systemd-2.33.2-4.18.1.x86_64 of SLES12 SP5.
Still present in util-linux-systemd-2.36.2-150300.4.20.1.x86_64 of SLES15
SP3.

Regards,
Ulrich Windl


