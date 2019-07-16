Return-Path: <SRS0=TRZh=VN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD57C76188
	for <util-linux@archiver.kernel.org>; Tue, 16 Jul 2019 13:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9242D2173C
	for <util-linux@archiver.kernel.org>; Tue, 16 Jul 2019 13:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmail.hu header.i=@gmail.hu header.b="K9rvK04h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbfGPNTl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:19:41 -0400
Received: from mail.gmail.hu ([94.199.52.210]:41840 "EHLO mail.gmail.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbfGPNTl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Jul 2019 09:19:41 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jul 2019 09:19:41 EDT
Received: from filter.gmail.hu (g2.gmail.hu [192.168.79.12])
        by mail.gmail.hu (Postfix) with ESMTP id C6618945BBD87
        for <util-linux@vger.kernel.org>; Tue, 16 Jul 2019 15:10:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmail.hu; h=
        user-agent:message-id:subject:subject:from:from:date:date
        :content-transfer-encoding:content-type:content-type
        :mime-version:received; s=default; t=1563282660; x=1565097061;
         bh=fMR3TrEJT+rqkaU88iN82XZs4XLe7WM/GE46n3Y9d/0=; b=K9rvK04hi4Ss
        TNYezPN3I2CZ8hkA+RaAY8UFrSZYTLFmqS2ttbULJlAEKRiMWegjQym+vJNsB0Pb
        cZnodfOVP9HktBEiI194CYZNWy2JazIn6SEaggXkTiuV4/T1dUnw07tdsOX2B9oZ
        29sny5Bwe1V+BP6g7b0URqYLPM++PaY=
Received: from mail.gmail.hu (storage1.gmail.hu [192.168.0.121])
        by mail.gmail.hu (Postfix) with ESMTPA id C6B95945BBAD2
        for <util-linux@vger.kernel.org>; Tue, 16 Jul 2019 15:10:26 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 16 Jul 2019 15:10:26 +0200
From:   Istvan Gabor <suseuser04@gmail.hu>
To:     Util linux <util-linux@vger.kernel.org>
Subject: fdisk does not allow overwrite default/suggested value
Message-ID: <55e1e62f0a4c14c93245292c2a62d789@gmail.hu>
X-Sender: suseuser04@gmail.hu
User-Agent: G-Mail Webmail
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Dear util-linux developers:

I'v been using cfdisk and fdisk for a long time.
Currently I have util-linux 2.31.1 in openSUSE Leap 42.3.

Recently I've run into this issue:

I use USB hard drive docker and the system gets
false optimal_io_size values for hard drives.

For a detailed description of the problem, see:

Linux SSD partition alignment =E2=80=93 problems with external USB-to-SATA=
=20
controllers =E2=80=93 I

https://linux-blog.anracom.com/2018/12/03/linux-ssd-partition-alignment-pro=
blems-with-external-usb-to-sata-controllers-i/

I wanted to use fdisk for partitioning a 1 TB disk.
fdisk wanted to start the first partition at sector
65535 (based on the wrong optimal_io_size value, I
guess). I tried to overwrite the suggested value with
2048 but got "value out of range" error.

My point is that fdisk insist to use its suggested
value and don't let the user set other value.

In my opinion it is a bad policy, the program
should allow to overwrite the suggested value
and use it. If it is dangerous, then there should
be a specific option to enable the behavior or
double check if the user really wants to use the
value entered. But it should be possible to use
other values than the offered ones, especially if the
offered value is wrong.

Best regards,

Istvan

