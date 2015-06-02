Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758610AbbFBKxW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Jun 2015 06:53:22 -0400
Date: Tue, 2 Jun 2015 12:53:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Cristian =?iso-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] sys-utils: lscpu segfaults when built with
 -fsanitize=address
Message-ID: <20150602105320.GI7285@ws.net.home>
References: <1433011901-113397-1-git-send-email-crrodriguez@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1433011901-113397-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 30, 2015 at 03:51:41PM -0300, Cristian Rodríguez wrote:
> This is expected and a false positive, exclude the vmware detection
> trick when __SANITIZE_ADDRESS__ is defined.
> ---
>  sys-utils/lscpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, but I have added a preprocessor warning when the detection
 is disabled by -fsanitize=address. Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
