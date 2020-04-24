Return-Path: <SRS0=00Jr=6I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D854EC5519A
	for <util-linux@archiver.kernel.org>; Fri, 24 Apr 2020 09:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B706820724
	for <util-linux@archiver.kernel.org>; Fri, 24 Apr 2020 09:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdnk/arj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXJVc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgDXJV2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Apr 2020 05:21:28 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37081C09B045
        for <util-linux@vger.kernel.org>; Fri, 24 Apr 2020 02:21:28 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i3so9607500ioo.13
        for <util-linux@vger.kernel.org>; Fri, 24 Apr 2020 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MnWaVOr+uqRM7kwkNptAGbLBJ53R4DBTN5zhXn+NOuI=;
        b=Qdnk/arjgKFKOusLu6ouFLvhxLXldXFp+KGL18WHGAVqzGf5bOD+ZiL+lH/kRDLUez
         EjhG2NqAzTusS9fbkCqjn2Nf6r+XhGwQOqmArJduXmhxtY89FZeMu+Yie0/3re+BcHdt
         UEL2FRkqv6QwACJxSaq0vTl0f8Dv+5Tz3M5zJb3osl/7rbUQRlrJh7NEkcvRx9jduzLm
         Vqz1igpFmIHDULl1yhRjd9R53WxI29MqfZZT9sRz2aW3sgalFoGHGPd9T/k8iAfhHOvD
         tn9QPgJh4ExGTYZt566hlhZyFnSn3qzt9Zl3vh1iJKsOTltqKi5IDOfh9L4LnM3Ye0cV
         yDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MnWaVOr+uqRM7kwkNptAGbLBJ53R4DBTN5zhXn+NOuI=;
        b=JeSVBUjLuKU8daq+e35kY186ibephRhpgLRyWLlu0U58MHtfWlBn02h1dQyS5AtIaW
         RwaGacKl052fDDR6tZVp2WfZHL/PyW3LJjNMlqeYa8OIjj842oVp7oNoH8FxNmMbh+Q7
         wU93mIuoLP8/5NthrwHJbKZKolXjg8z8b/wHE5h525Ozo8WPZ+LVp689+U3CzF/lGBL+
         jMM6sv/fKuzbIIdk9lKQcSWSJaTLL5aQaAyK76PiXnYSE7oWWG9KxASVLNK9E1iv1Jso
         D2Sk4Qbp0l2IGnqyMPn2m/u/J3qc0yZoo8b8o3zfclguJnHXyNpar+rz+uweNWMHiThN
         sjDA==
X-Gm-Message-State: AGi0PubQlt3RrEB0jH6fMdqTYcburB5TpVI2O7ULe1tdV7gLnqhMEyNk
        lkCXmUxI18xaRFS/nItkGJGe6tiKHma3dq9PPKE=
X-Google-Smtp-Source: APiQypJWxSrSH+B25O7ZliyYvGjSekNkdm+E1rjZooZz+lBGukiQQWUfs8QWC3qH/v9Fev4PH94PLnmDtCeI0bMkN0Q=
X-Received: by 2002:a5d:9685:: with SMTP id m5mr7990913ion.36.1587720087556;
 Fri, 24 Apr 2020 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200415211653.5455-1-michael-dev@fami-braun.de>
 <87o8rrdulx.fsf@x220.int.ebiederm.org> <9379f1f3b13b33e3a80b7cb4a58de8b8@fami-braun.de>
In-Reply-To: <9379f1f3b13b33e3a80b7cb4a58de8b8@fami-braun.de>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Fri, 24 Apr 2020 11:21:15 +0200
Message-ID: <CAHO5Pa0OkdnTYRkzEsCV0=kAJZXDaSnVriEUAq3Zt-6csP3wFQ@mail.gmail.com>
Subject: Re: [PATCH] Fix PID namespace persistence
To:     michael-dev <michael-dev@fami-braun.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        util-linux@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Apr 19, 2020 at 1:06 AM michael-dev <michael-dev@fami-braun.de> wrote:
>
> Am 16.04.2020 22:49, schrieb ebiederm@xmission.com:
> > Why all of the extra code motion and change?
> >
> > Your description sounds like only the first hunk is necessary.  Did
> > something else get mixed into this change?  Or are all of the hunks
> > necessary?
>
> Because after unsharing, pid_for_children is a dangling symlink.
> So if (forkit) needs to be before /* wait for bind_ns_files_from_child()
> */.
> Moving this results in an overlapping use of the pid variable, so that
> gets renamed.
> Additionally, we cannot wait for the forkit child (bash) to exit before
> triggering and waiting for the bind-mounting child to bind-mount the
> persistent namespace. So forking and waiting for the forkit child (bash)
> needs to become splitted.

@Michael: I confim theproblem, and thanks for this fix.

@Zak: an analogous fix is required for time namespaces.

Cheers,

Michael


-- 
Michael Kerrisk Linux man-pages maintainer;
http://www.kernel.org/doc/man-pages/
Author of "The Linux Programming Interface", http://blog.man7.org/
