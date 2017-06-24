Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdFXUpS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 16:45:18 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F63322B6C
        for <util-linux@vger.kernel.org>; Sat, 24 Jun 2017 20:45:17 +0000 (UTC)
Received: by mail-ua0-f182.google.com with SMTP id j53so52349575uaa.2
        for <util-linux@vger.kernel.org>; Sat, 24 Jun 2017 13:45:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a71a588d9507911d541388872a987d219d236f49.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
 <cover.1498312509.git.ps@pks.im> <a71a588d9507911d541388872a987d219d236f49.1498312679.git.ps@pks.im>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 24 Jun 2017 13:44:56 -0700
Message-ID: <CALCETrUzOmx4-x0ZB6R9YkM4fXLURw8uEpCjd6gbAEWCAQmqBQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] setpriv: proxy function checking whether a capability
 is set
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>,
        Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 24, 2017 at 7:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> The loop in `print_caps` iterates over every capability, checks whether
> it is set and, if so, prints out its name. Currently, the checking and
> printing is rather intertwined, making it harder to extend the check
> whether we own a capability.
>
> Prepare code for the introduction of ambient capabilities by
> disentangling the code checking for a capability and printing code. A
> new function `has_cap` is introduced and `print_caps` will now simply
> call out to it and only handle printing itself. This easily allows to
> extend the capability check based on which capability set is queried.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
