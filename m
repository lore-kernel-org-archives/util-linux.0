Return-Path: <SRS0=2g+Q=UD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A99C282CE
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 11:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA57124891
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 11:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfFDL6l (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:58:41 -0400
Received: from mail.aixigo.de ([5.145.142.10]:34587 "EHLO mail.aixigo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfFDL6l (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Jun 2019 07:58:41 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 07:58:40 EDT
Received: from srvvm01.ac.aixigo.de (mail.ac.aixigo.de [172.19.96.11])
        by gate5a.ac.aixigo.de (OpenSMTPD) with ESMTPS id b816f385 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <util-linux@vger.kernel.org>;
        Tue, 4 Jun 2019 13:51:59 +0200 (CEST)
Received: from dpcl082.ac.aixigo.de (dpcl082.ac.aixigo.de [172.19.97.128])
        by srvvm01.ac.aixigo.de (8.15.2/8.15.2/Debian-8) with ESMTP id x54Bpwfh1699006;
        Tue, 4 Jun 2019 13:51:59 +0200
To:     util-linux@vger.kernel.org
From:   Harald Dunkel <harald.dunkel@aixigo.com>
Subject: careful with that umount options, Eugene
Message-ID: <6c72d034-e172-9beb-e61b-bb74807ded0a@aixigo.com>
Date:   Tue, 4 Jun 2019 13:51:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.1 at srvvm01.ac.aixigo.de
X-Virus-Status: Clean
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi folks

by accident I pasted

	umount ls -al /mnt/

into bash. My bad. AFAICT /proc was umounted immediately, the
rest died slowly. Don't try this at home.

Point is, according to the man page this command line should
have triggered an error message. "umount ls -al" doesn't make
sense.

Do you think the command line parser could be fixed?

util-linux is version 2.29.2-1+deb9u1, as included in Debian.
Of course I checked the diff for umount.c between 2.29 and
3.34-rc2. Apparently the getopt code has been improved, but I
did not notice a fix for this particular problem.


Thanx in advance. Keep on your good work
Harri
