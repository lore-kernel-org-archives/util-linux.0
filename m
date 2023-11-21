Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BD2C5ACB3
	for <util-linux@archiver.kernel.org>; Tue, 21 Nov 2023 06:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjKUGJR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 Nov 2023 01:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUGJR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 21 Nov 2023 01:09:17 -0500
Received: from mx08.samokat.ru (mx08.samokat.ru [45.90.244.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E189F
        for <util-linux@vger.kernel.org>; Mon, 20 Nov 2023 22:09:13 -0800 (PST)
Received: from os-081902002.samokat.io (localhost.localdomain [127.0.0.1])
        by mx08.samokat.ru (Proxmox) with ESMTP id 19B851657BB
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2023 04:46:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samokat.ru; h=cc
        :content-description:content-transfer-encoding:content-type
        :content-type:date:from:from:mime-version:reply-to:reply-to
        :subject:subject:to:to; s=mx08; bh=xLa+Y+8oZsPLxM4DfYhRok3qXqR40
        9xGlNHGB4ORPBU=; b=nq9U+KbUhBX35Ppy9fkCjj71//KdsyRZRMpWBZ/tmpNXq
        2E8YK6c44opLypnmkL5HZP3iYTOWBXc5cx95t8vxU68sMNC1IRNepS9zLp+fLwcu
        kKxmuolqiHcmt8Mf3CdtpLjEZIUnRWyr0HDTruUz7grJDtvTMtJLP3LVkdpY1VHv
        ls3Schh3VvhjpHJV5kSWTi20ptJ38GRRAhdUlVDQioJMGIP7VBWfaqgOIIidh2km
        6XxuvPfvJWm9d49ss/uoU5JrA6di/9QtelerIhCJSURo2Ota4YzyycOIyibfulYq
        NrtfYfM/O8CVdVLGUsoYMixezra2fhKGoDx6idvPw==
Received: from ksmg-08.samokat.ru (ksmg-08.samokat.ru [10.18.145.3])
        by mx08.samokat.ru (Proxmox) with ESMTPS id A55AD147A8C
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2023 04:21:01 +0300 (MSK)
Received: from os-081902003.samokat.io (localhost [127.0.0.1])
        by ksmg-08.samokat.ru (Postfix) with ESMTP id 13EBA1A0021
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2023 04:21:01 +0300 (MSK)
Received: from [85.195.105.114] (os-081144001.samokat.io [10.18.144.1])
        by ksmg-08.samokat.ru (Postfix) with ESMTP
        for <util-linux@vger.kernel.org>; Tue, 21 Nov 2023 04:21:00 +0300 (MSK)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Understand me
To:     util-linux@vger.kernel.org
From:   "Anna Pechorin" <ap@samokat.ru>
Date:   Mon, 20 Nov 2023 17:21:00 -0800
Reply-To: dealings100@hotmail.com
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181488 [Nov 20 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ap@samokat.ru
X-KSMG-AntiSpam-Rate: 60
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Prob_reply_not_match_from}, {Prob_msgid_missed_1b}, {Tracking_cluster_exceptions, from}, {Tracking_free_reply_not_from}, {Tracking_cnf_strong}, {Tracking_dating_nourl, reply1}, {Tracking_dating_reply, mail_free}, {Tracking_from_domain_doesnt_match_to}, samokat.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;hotmail.com:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/21 00:12:00 #22490067
X-KSMG-AntiVirus-Status: Clean, skipped
Message-Id: <20231121014636.19B851657BB@mx08.samokat.ru>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello

How are you, I hope this email finds you in good health and spirit? Before =
I continue let me humbly apologize for coming into your space unsolicited. =
Nonetheless, I take solace in the fact that it is with the best intention a=
nd for our mutual benefit.

I chose you among other contacts I came across in my search for someone who=
 can be of help.  It took a great deal of brain storming to arrive at my de=
cision I must say, with the hope that my contact with you will be private a=
nd confidential.

The business idea that I have is to partner with you by investing in your c=
ountry and you becoming my fund manager. This whole idea is borne out of th=
e fact that presently I am totally indisposed to carry out any financial tr=
ansaction owing to restrictions relating to the Russia /Ukraine war and the=
 suspicious death of my husband, Ivan Pechorin in the hand of our President=
 Vladimir Putin. =


It will be an absolute pleasure, if you would have the wherewithal to handl=
e this project to my satisfaction. Every detail concerning this project wou=
ld be laid bare to you upon indication of your interest. =


Pls. strictly send response to: dealings100@hotmail.com


Best regards

Anna Pechorin.

