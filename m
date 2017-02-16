Return-Path: util-linux-owner@vger.kernel.org
Received: from nymeria.archlinux.org ([89.238.67.251]:48294 "EHLO
        nymeria.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdBPKg3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 16 Feb 2017 05:36:29 -0500
Received: from nymeria.archlinux.org (localhost.localdomain [127.0.0.1])
        by nymeria.archlinux.org (Postfix) with ESMTP id 204F34038A
        for <util-linux@vger.kernel.org>; Thu, 16 Feb 2017 11:36:26 +0100 (CET)
Received: from mail-ua0-f171.google.com (mail-ua0-f171.google.com [209.85.217.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: arodseth)
        by nymeria.archlinux.org (Postfix) with ESMTPSA id A7AD940338
        for <util-linux@vger.kernel.org>; Thu, 16 Feb 2017 11:36:25 +0100 (CET)
Received: by mail-ua0-f171.google.com with SMTP id y9so7970248uae.2
        for <util-linux@vger.kernel.org>; Thu, 16 Feb 2017 02:36:25 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Alexander_F_R=C3=B8dseth?= <xyproto@archlinux.org>
Date: Thu, 16 Feb 2017 11:35:43 +0100
Message-ID: <CAG7ayysW1RokKo0mkKksvznx==hCOhaDzKQHXfP5AnJrjUhApg@mail.gmail.com>
Subject: Re: [PATCH] rename: add --dry-run option
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Using --no-act for consistency sounds like a good decision.

Thanks for applying the patch and for maintaining util-linux!

--=20
Sincerely,
    Alexander F R=C3=B8dseth / xyproto
