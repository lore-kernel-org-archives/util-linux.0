Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F27EE4996
	for <util-linux@archiver.kernel.org>; Sun, 20 Aug 2023 22:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjHTWuN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 20 Aug 2023 18:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjHTWuM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 20 Aug 2023 18:50:12 -0400
X-Greylist: delayed 25376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Aug 2023 15:50:06 PDT
Received: from smart3-pmg.ufmg.br (smart3-01-pmg.ufmg.br [150.164.64.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF14A1
        for <util-linux@vger.kernel.org>; Sun, 20 Aug 2023 15:50:06 -0700 (PDT)
Received: from smart3-pmg.ufmg.br (localhost.localdomain [127.0.0.1])
        by smart3-pmg.ufmg.br (Proxmox) with ESMTP id 98D6E5A6B64
        for <util-linux@vger.kernel.org>; Sun, 20 Aug 2023 12:30:01 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ufmg.br; h=cc
        :content-transfer-encoding:content-type:content-type:date:from
        :from:message-id:mime-version:reply-to:reply-to:subject:subject
        :to:to; s=mail; bh=aB6phz2CCV0fOdUx+FEpXbqcMS5qcYYIVmsV4Zzs0ug=; b=
        PnNRAGZvOvI6WGsEHSE2mjgi9H2IwhYRuArtU+nZXZ5QchK82WKTta6Xe2m5MEJ0
        O0hru6ZQmWAyka2AapabYYK8kqlf0bzek5gWEmZ3odSWjzfXK6MuPsKwIC1X7mGm
        4qiXL1VYG/M7nP5bwl007VNjvnzSTqaU7Y/R7uUeMCuBTPbnw/wSc9eFW2QzbfVF
        S327LQPkYq1zXIyI0ycsL/PzICEdyp3kpsyu9U30zPjbHGLPEwBLURm6rmBsyqbv
        sklTuH86Xg/gTei6NIt+PQ5mj+Dv2Rz1Fbpf9rQGRskuS5FHawLpIwOcOYrGqmPS
        cJ1Qy3JpXvKdetJ7TDpsIA==
Received: from bambu.grude.ufmg.br (bambu.grude.ufmg.br [150.164.64.35])
        by smart3-pmg.ufmg.br (Proxmox) with ESMTP id C43035A6AE1
        for <util-linux@vger.kernel.org>; Sun, 20 Aug 2023 12:29:44 -0300 (-03)
Received: from ufmg.br ([98.159.234.166])
          by bambu.grude.ufmg.br (IBM Domino Release 10.0.1FP3)
          with ESMTP id 2023082012291119-944554 ;
          Sun, 20 Aug 2023 12:29:11 -0300 
Reply-To: "Kristine Wellenstein" <inform@calfd.org>
From:   "Kristine Wellenstein" <luanacsg@ufmg.br>
To:     util-linux@vger.kernel.org
Subject: [RE]: RE:
Date:   20 Aug 2023 11:29:10 -0400
Message-ID: <20230820112910.9C1E7CCBE0B75ACC@ufmg.br>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at
 20-08-2023 12:29:11,
        Serialize by Router on bambu/UFMG(Release 10.0.1FP3|August 09, 2019) at 20-08-2023
 12:29:44,
        Serialize complete at 20-08-2023 12:29:44
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset="utf-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Sehr geehrter Beg=C3=BCnstigter,

Die EmilyWells Foundation ermutigt Menschen, sich ehrenamtlich f=C3=BCr soz=
iale oder wohlt=C3=A4tige Zwecke zu engagieren und den weniger Gl=C3=BCckli=
chen zu helfen. Lasst uns alle die wichtige Botschaft dieses gro=C3=9Fartig=
en Tages verbreiten und uns f=C3=BCr das bedanken, was wir haben.

Ich bin Kristine Wellenstein, die Gewinnerin des Mega Millions-Jackpots in =
H=C3=B6he von 426 Millionen US-Dollar am 28. Januar. Ich gebe offiziell bek=
annt, dass Sie als einer von f=C3=BCnf Empf=C3=A4ngern einer Spende in H=C3=
=B6he von 2.300.000 ausgew=C3=A4hlt wurden. Dollar von der Emily Wells Foun=
dation.

Diese Spende ist im Gedenken an meinen verstorbenen Enkel, der gerade einen=
 Tag gelebt hat.
F=C3=BCr weitere Informationen antworten Sie bitte auf diese E-Mail.

Beste gr=C3=BC=C3=9Fe:

Kristine Wellenstein
Gr=C3=BCnderin/Vorsitzende: EmilyWells. Stiftung, Schenkung


