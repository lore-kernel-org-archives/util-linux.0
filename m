Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ot0-f176.google.com ([74.125.82.176]:33035 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934338AbdCLRIg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Mar 2017 13:08:36 -0400
Received: by mail-ot0-f176.google.com with SMTP id 19so101423654oti.0
        for <util-linux@vger.kernel.org>; Sun, 12 Mar 2017 10:08:36 -0700 (PDT)
Subject: Re: missing syms @ link filed as bugzilla.kernel.org#194857
To: L A Walsh <lkml@tlinx.org>, util-linux@vger.kernel.org
References: <58C52223.1000008@tlinx.org>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <58C58092.8060206@gmail.com>
Date: Sun, 12 Mar 2017 12:08:34 -0500
MIME-Version: 1.0
In-Reply-To: <58C52223.1000008@tlinx.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

L A Walsh wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=194857
>
> Different utils gave different syms -- wasn't just the color
> related ones -- but like nothing is linking in files
> from the '<proj>/libs' dir...

May I suggest retrying at -j1.
It would also be more clear if you post the options for configure, if any.
Is this x86_64 or something different?

That info would help narrow down the issue.

   -- Bruce

