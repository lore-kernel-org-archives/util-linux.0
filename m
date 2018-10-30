Return-Path: <SRS0=Rzvl=NK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B011C2BC61
	for <util-linux@archiver.kernel.org>; Tue, 30 Oct 2018 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03A020664
	for <util-linux@archiver.kernel.org>; Tue, 30 Oct 2018 22:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndfOGJdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03A020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeJaG6d (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:58:33 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:37560 "EHLO
        mail-yb1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbeJaG6c (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 31 Oct 2018 02:58:32 -0400
Received: by mail-yb1-f169.google.com with SMTP id d18-v6so5750956yba.4
        for <util-linux@vger.kernel.org>; Tue, 30 Oct 2018 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OaJ2LDRbpe8codwBLVAsG5G+HNo+zJtG9QBp0bRn1ZE=;
        b=ndfOGJdnAXJs7O8SgQ4VL16A+hkX898+Pj2JOlxZ+ZZNYnYsnIVE2y0StNF6Oh2/tL
         dz/4Z2vNrsacQ2iuhwVbq69qqIHWHZ5qdGdm/o6Exq7MhkP77MOnxd5/R+O4LLiUSfF+
         hkdx646/qAwQm5K79mXibY/UdgO/5AJNdbACzmpADZHEdUT3U6bNZNo7ZgaH7ro/MYQi
         dCT79xiLr65ct7hsl0UEiIx8xtwMPFejKcBlu41kkxxd75bbFfoLrhrL42szfHnf/FYz
         pNVQ+C4wfq5s6H0bDL9QVjEpgaElDd0a0jK3nmXndwJ4dNvyg5ZvU1+auyGAcwxL1lo5
         l7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OaJ2LDRbpe8codwBLVAsG5G+HNo+zJtG9QBp0bRn1ZE=;
        b=ALpbpUlTy3iPmNIGVgzPzdQ+/8SU5pYJ7DIQCJqzZNOpu6hmp1mzJlfKwnt11xcOtY
         nvkXcJH1wVwm0gGQ45WPXEi0ZqXIJ/DX8DcN1a+aCGQYdtPVw64URwhSmMGYBo5xfvVR
         7nvQ8TxK4IiuvmyRVJnBPAhR3tvWICYczuGhGPJ5xk6L8HYv66EjEE/U06ZNzQUV/dOj
         uQNqE18Es++5kQ+LpQmqs+oz8gDMK7ve6hnRzBsXD1DmVYujQvV87ni4fEsiEuu7/1nz
         2PFBdDWqkWkhH7ddPj3gErcA6Pc8TEDe1qot2v7EXnz9u/nkwmBpP+GRwZpPqNPPUGox
         e4WQ==
X-Gm-Message-State: AGRZ1gIX+IyNEz6b5SpuCGLj3LG1pWb7rnAg3yqm5KOoXRGFS8PmOKSM
        9QyPtp3yK9GjS2FbaRzGC0+JV+4DD/TO8GNM5Q5IuQ==
X-Google-Smtp-Source: AJdET5dv9Wk1D37dgFCCbEEvylG2sczbGYd39LF2sLmJKPSSUzMOnqf5I3zdZYnTtki96C4EpY7HEYw5zWhp/7Xlo5A=
X-Received: by 2002:a25:ca0c:: with SMTP id a12-v6mr577217ybg.143.1540936998816;
 Tue, 30 Oct 2018 15:03:18 -0700 (PDT)
MIME-Version: 1.0
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Tue, 30 Oct 2018 15:03:07 -0700
Message-ID: <CAJx26kWFgTEQ=sMf1Uepw8gor6g7cn6QYeYz34vFyb-uCGDLMQ@mail.gmail.com>
Subject: Rtcwake s5 with poweroff
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello all,

I have a system that doesn't have "shutdown", instead it uses
"poweroff". For "rtcwake -m off" (s5), rtcwake sets the wakealarm and
then issues a shutdown command. I am thinking about putting together a
patch that will allow rtcwake to use "poweroff". It will first try to
look for the "shutdown" command and if it is not existent, use
"poweroff" instead. Are these changes acceptable?

Thanks,
Justin
