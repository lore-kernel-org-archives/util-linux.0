Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1EDEB64DC
	for <util-linux@archiver.kernel.org>; Tue, 11 Jul 2023 16:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjGKQWp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jul 2023 12:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGKQWo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 11 Jul 2023 12:22:44 -0400
X-Greylist: delayed 753 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 09:22:37 PDT
Received: from correo.48k.eu (correo.48k.eu [217.70.190.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02C30DD
        for <util-linux@vger.kernel.org>; Tue, 11 Jul 2023 09:22:37 -0700 (PDT)
Message-ID: <d7073192-c58d-2592-56d7-d15a837dc97f@soleta.eu>
Date:   Tue, 11 Jul 2023 18:10:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   "Jose M. Guisado" <jguisado@soleta.eu>
Subject: libfdisk python bindings
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi all,

I am developing a python binding for libfdisk, it is released under
the terms of the LGPL2.1+.

I have uploaded a simple website for the project, it is available at:
https://48k.eu/python-libfdisk/

I am using this for FOSS project to partition clients remotely.
The target computers run a Python client that uses python-libdisk to
partition the disks.

Any feedback is welcome, thanks!

P.S: Karel suggested [1] time ago that I could report progress here,
so here I am :-).

[1] 
https://lore.kernel.org/util-linux/20220411081504.izsddsnb4m3uguf5@ws.net.home/

--
Jose.
