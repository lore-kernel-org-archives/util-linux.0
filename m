Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:35598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754804AbdFXUnc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 16:43:32 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7064722B69
        for <util-linux@vger.kernel.org>; Sat, 24 Jun 2017 20:43:31 +0000 (UTC)
Received: by mail-vk0-f49.google.com with SMTP id y70so26378480vky.3
        for <util-linux@vger.kernel.org>; Sat, 24 Jun 2017 13:43:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1498312509.git.ps@pks.im>
References: <cover.1498312509.git.ps@pks.im>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 24 Jun 2017 13:43:10 -0700
Message-ID: <CALCETrVGTZ=2Y+fOKONYZ8_nuvZC7HE2TUsJTH-beQHU7vLgJw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Ambient capabilities for setpriv
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>,
        Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> Hi,
>
> this patch series implements support for ambient capabilities in
> setpriv(1). Ambient capabilities have been implemented with Linux
> 4.3 by Andy Lutomirski [1]. Quoting from capabilities(7):
>
>     This is a set of capabilities that are preserved across an
>     execve(2) of a program that is not privileged.
>
> The patches are inspired and squarely based on published patches
> for util-linux by Andy [2]. As these commits seem to never have
> been upstreamed, I've contacted Andy a few days ago whether he
> intends to do so in the near future, but got no response. Anyway,
> as I would like to have ambient capabilities available in
> setpriv, I took up the baton and wrote this patch series.

Sorry, was swamped.  I very much appreciate your doing this.
