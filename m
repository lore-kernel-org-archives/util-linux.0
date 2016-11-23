Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.parknet.co.jp ([210.171.160.6]:47721 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbcKWFEZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2016 00:04:25 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTP id 80ECF170001
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2016 14:04:23 +0900 (JST)
Received: from devron.myhome.or.jp (root@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-6) with ESMTPS id uAN54KVM002730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2016 14:04:21 +0900
Received: from devron.myhome.or.jp (hirofumi@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-6) with ESMTPS id uAN54Je4031900
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2016 14:04:19 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] lsns: Fix parser for /proc/<pid>/stat which is including space in comm
References: <87a8cvk01b.fsf@mail.parknet.co.jp>
        <20161122204301.GB21655@vapier.lan>
Date: Wed, 23 Nov 2016 14:04:19 +0900
In-Reply-To: <20161122204301.GB21655@vapier.lan> (Mike Frysinger's message of
        "Tue, 22 Nov 2016 12:43:01 -0800")
Message-ID: <87fumihjn0.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger <vapier@gentoo.org> writes:

> On 19 Nov 2016 23:38, OGAWA Hirofumi wrote:
>> 
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> can you please include an example line in the commit message ?

ok.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
