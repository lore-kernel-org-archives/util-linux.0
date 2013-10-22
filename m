Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34680 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab3JVOMu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Oct 2013 10:12:50 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp18so3872687obc.29
        for <util-linux@vger.kernel.org>; Tue, 22 Oct 2013 07:12:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131018083452.GB15115@x2.net.home>
References: <CAF8BazAW7xxXpO1-vCBJvfvORBLXnJkDxv=qagoe0ZJe-12aJg@mail.gmail.com>
	<CAF8BazDFWf7-NPwCr7Cg=aV9prKsWNUxJu2neZ3x+8XP1fZPHQ@mail.gmail.com>
	<20131018083452.GB15115@x2.net.home>
Date: Tue, 22 Oct 2013 18:12:49 +0400
Message-ID: <CAF8BazDK6_RMQ7KR5aUhAf10PZmp79NN5VSmy3oY_tQcoOee-Q@mail.gmail.com>
Subject: Re: Per-filesystem default mount options
From: Aleksey Midenkov <midenok@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 18, 2013 at 12:34 PM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Oct 16, 2013 at 06:13:17PM +0400, Aleksey Midenkov wrote:
>> Is it possible to specify per-filesystem default mount options
>> somewhere in configuration file?
>
>  /etc/fstab, or tune2fs for extN, or /etc/nsfmount.conf for NFS.
>
>  The per-filesystem-type default options are also hardcoded in kernel.
>
>     Karel

That's true, they are hardcoded in kernel. But, there is a need to
have them customized. I know, there is a ton of user-level utils that
maybe can provide it. IMHO this basic feature is important for the
core.

>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
