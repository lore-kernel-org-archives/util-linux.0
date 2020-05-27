Return-Path: <SRS0=vWqr=7J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE845C433E0
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 12:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8516B207CB
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 12:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2lgOwes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgE0MiO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 May 2020 08:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgE0MiK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 May 2020 08:38:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC806C08C5C1
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 05:38:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id k11so2694553ejr.9
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=S65dzra2BXdWLdW3Z0Y4fsmozl+naxP9oiYHpLm4g6Q=;
        b=h2lgOwesh3xK8algg7h/aBAZomVIrkcz3y4UCsNxn+3HbaO/bW1uRmZcQTlXUCKb17
         0/P6OG1iuP+3dKd+k1w90J4Aka++tvetcIdoOILLxCqUrsgW4M09yMwI8U9Plao3PtOe
         tv0VryjMKmRtOiy+59U4Y5tvHY5Xsotpeb9bxW367OIdHHFVpwjVblXSaXRhesUQAUnd
         KDTXicF6eqq/bto5MnCYr1JMUzl8I0w9wcdOMFMDh4Hxp9jhYYEnaXYctFrdpvFzAPer
         IZW5QnPgE9NYegUsqWcec5uoQex986ujiZ2qS6ZqxO9vyCZdsgM2PfUYIB89Edn24ZMj
         1+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=S65dzra2BXdWLdW3Z0Y4fsmozl+naxP9oiYHpLm4g6Q=;
        b=kAG5zrU5WGqLkn4DytpUtaz8JPR1npZ6d/2PezlyV1Pk1BSixJjb2iiHjTApyAawSS
         KA/vNC3y3EeJshIVGjgRwrU4jZAzbd37j3b1E6F38Lm7v03CwG/arnveijcuyGChGoaD
         Bl8XaHcKdedPdDdIqPm+rfXhICWlASgVAvaEeTOqvVjjp+lGhtHpwWNOeyqAUKtO4JTb
         O6scP3WF5HO748P4cV+iCouTwRBauDx/3l80g/l8Fmx1ew28nBz4JbYzjYE7s7J5cT1N
         vE39dAY3nuefPkVhId56aoGfJzIIhsepu/T1MgddxudJAA/EVCI/0s3PL50r4RsH1e79
         hPkA==
X-Gm-Message-State: AOAM531FMNIgr53o4fMhzpMM1mHrT3WlSiiLtvBbid9Lmx75gSVtnE2Y
        U/6rxcRcPIw/FQlvpTtyQWhMVpqMBJTlraC9sW4=
X-Google-Smtp-Source: ABdhPJxaon2hABu7fK8rs+qIiyi3z68h0uqnED7smOY4IGSBxNPtfA99hgCJrEG7AnEpwFiHAl3FvL1aIqa8PRyvD4E=
X-Received: by 2002:a17:906:c29a:: with SMTP id r26mr5792280ejz.286.1590583088278;
 Wed, 27 May 2020 05:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
 <20200525121745.rmdn47zlchtf76fh@ws.net.home> <4d4bb487-4a9c-1fcb-71a6-059379597d15@gmail.com>
 <20200526085048.23ue2dcz7cvc5wx7@ws.net.home>
In-Reply-To: <20200526085048.23ue2dcz7cvc5wx7@ws.net.home>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 27 May 2020 14:37:57 +0200
Message-ID: <CAKgNAkjsmUzGRrFqUCEX_VbKBN=OUyYY17TekqzEgx+WoppP5Q@mail.gmail.com>
Subject: Re: [PATCH 1/9] Manual pages: nsenter.1, unshare.1: update references
 to *_namespaces(7) pages
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 26 May 2020 at 10:50, Karel Zak <kzak@redhat.com> wrote:
>
> On Mon, May 25, 2020 at 03:13:18PM +0200, Michael Kerrisk (man-pages) wro=
te:
> > A follow-up question. There was one piece of the unshare(1) examples
> > that I did not try to rework, because I simply don't understand it:
> > v
> >        Establish  a  persistent  mount  namespace  referenced by the bi=
nd
> >        mount /root/namespaces/mnt.  This example shows a  portable  sol=
u=E2=80=90
> >        tion,  because  it  makes sure that the bind mount is created on=
 a
> >        shared filesystem.
> >
> >            # mount --bind /root/namespaces /root/namespaces
> >            # mount --make-private /root/namespaces
> >            # touch /root/namespaces/mnt
> >            # unshare --mount=3D/root/namespaces/mnt
> >
> > I think you wrote this example. What does the sentence "This example sh=
ows
> > a portable solution, because it makes sure that the bind mount is creat=
ed
> > on a shared filesystem" mean? I think this needs clarification, and I'd=
 try
> > to do so, but it's not clear to me what the sentence is trying to say.
>
> Hmm... it should be "the /root/namespaces/mnt is on a private
> filesystem". The important thing is --make-private in this case,
> because for example on Fedora we use "shared" propagation flag for
> root FS and without bind + make-private you will be unsuccessful. The
> example makes it portable between distros.

Okay -- I'll send a patch, once the curent queue of patches I have
with you is cleared.

Thanks,

Michael


--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
