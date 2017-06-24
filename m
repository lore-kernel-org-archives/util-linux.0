Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdFXUrv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 16:47:51 -0400
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com [209.85.217.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11EA022B6F
        for <util-linux@vger.kernel.org>; Sat, 24 Jun 2017 20:47:51 +0000 (UTC)
Received: by mail-ua0-f179.google.com with SMTP id 70so52845174uau.0
        for <util-linux@vger.kernel.org>; Sat, 24 Jun 2017 13:47:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cd10a8262a2accb0f3fdaf92aad8cdc488c5d3c7.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
 <cover.1498312509.git.ps@pks.im> <cd10a8262a2accb0f3fdaf92aad8cdc488c5d3c7.1498312679.git.ps@pks.im>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 24 Jun 2017 13:47:29 -0700
Message-ID: <CALCETrUe4-Tv=i7tAkdnKmEZtU76UA2vOWuBYmQsspobinjGpg@mail.gmail.com>
Subject: Re: [PATCH 5/5] setpriv: support modifying the set of ambient capabilities
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>,
        Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> Right now, we do not support modifying the set of ambient capabilities,
> which has been introduced quite recently with Linux 4.3. As libcap-ng
> does not yet provide any ability to modify this set, we do have to roll
> our own support via `prctl`, which is now easy to do due to the
> indirections introduced in the preceding commits. We add a new command
> line argument "--ambient-caps", which uses the same syntax as both
> "--inh-caps" and "--bounding-set" to specify either adding or dropping
> capabilities.
>
> This commit also adjusts documentation to mention the newly introduced
> ability to modify the ambient capability set.
>

One question here: should requesting an ambient cap also implicitly
put it in the inheritable set, at least if --inh-caps isn't specified?

--Andy
