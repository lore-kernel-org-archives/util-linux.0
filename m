Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.netzguerilla.net ([217.11.57.120]:58115 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757708AbdKOQWy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Nov 2017 11:22:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 1A9F4100013
        for <util-linux@vger.kernel.org>; Wed, 15 Nov 2017 17:17:50 +0100 (CET)
Received: from mail.netzguerilla.net ([217.11.57.120])
        by localhost (sal.netzguerilla.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B5Z6SRL76M_K for <util-linux@vger.kernel.org>;
        Wed, 15 Nov 2017 17:17:49 +0100 (CET)
Received: from [IPv6:2003:dd:ff22:fd01:c4bc:c0b2:8ea7:2398] (p200300DDFF22FD01C4BCC0B28EA72398.dip0.t-ipconnect.de [IPv6:2003:dd:ff22:fd01:c4bc:c0b2:8ea7:2398])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id EC1D4100012
        for <util-linux@vger.kernel.org>; Wed, 15 Nov 2017 17:17:48 +0100 (CET)
From: kalle <kalle@projektwerkstatt.de>
Subject: mount: /etc/fstab
To: util-linux@vger.kernel.org
Message-ID: <96410831-0333-8fb6-c05f-4ae8856e43df@projektwerkstatt.de>
Date: Wed, 15 Nov 2017 17:17:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

hello,
In the sentence "then mount looks for a mountpoint and if not found then
for a device in the /etc/fstab file" it should be made clear that the
mountpoint refers to the /etc/fstab-file, e.g. "then mount looks in the
/etc/fstab file firstly for a mountpoint and if not found then secondly
for a device". I did not understand the sentence until now and wondered,
what was meant by 'mountpoint'.

greetings,
kalle
