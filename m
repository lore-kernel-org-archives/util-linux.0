Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55434 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754578AbaKRNAH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Nov 2014 08:00:07 -0500
Date: Tue, 18 Nov 2014 13:59:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] bash-completion: Invoke actual commands to be completed,
 not basenames
Message-ID: <20141118125955.GK6704@x2.net.home>
References: <1416083764-15187-2-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1416083764-15187-2-git-send-email-ville.skytta@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Nov 15, 2014 at 10:36:04PM +0200, Ville Skyttä wrote:
>  bash-completion/chsh    | 2 +-
>  bash-completion/eject   | 2 +-
>  bash-completion/findmnt | 8 ++++----
>  bash-completion/losetup | 4 ++--
>  bash-completion/lsblk   | 2 +-
>  bash-completion/setarch | 2 +-
>  bash-completion/setpriv | 2 +-
>  7 files changed, 11 insertions(+), 11 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
