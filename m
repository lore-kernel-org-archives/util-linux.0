Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.netzguerilla.net ([217.11.57.120]:51889 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdKUWoU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 21 Nov 2017 17:44:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 27EF4100017
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2017 23:44:19 +0100 (CET)
Received: from mail.netzguerilla.net ([217.11.57.120])
        by localhost (sal.netzguerilla.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ilLai11-A8B1 for <util-linux@vger.kernel.org>;
        Tue, 21 Nov 2017 23:44:18 +0100 (CET)
Received: from [IPv6:2003:dd:ff18:5c01:f524:9d9f:8d3e:771a] (p200300DDFF185C01F5249D9F8D3E771A.dip0.t-ipconnect.de [IPv6:2003:dd:ff18:5c01:f524:9d9f:8d3e:771a])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 072C0100012
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2017 23:44:17 +0100 (CET)
To: util-linux@vger.kernel.org
From: kalle <kalle@projektwerkstatt.de>
Subject: man lsblk
Message-ID: <bc06a7b2-87f3-50af-4e51-f9f3166186d4@projektwerkstatt.de>
Date: Tue, 21 Nov 2017 23:44:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

hello,
here some critics:
-I had problems with reading the label through `lsblk', when not using
privileges. And the related man-page doesn't mention privilege matters.
For what is mentioned (in the `Notes'), that /sys/dev/block has to be
readable, my systems seems to be ok (read and write rights granted for
`others') -> I assume that it is a question of privileges, which should
be better documented
-proposition: put the options of `lsblk(8)' explicitly in the man-file
instead than only in `lsblk --help'
-`lsblk -m -o LABELs'shows only LABELs, but why? While `lsblk -o LABEL
-m' shows both. I think the options should be commutative...
-after unmounting a device `lsblk' doesn't list it anymore

greetings,
kalle
