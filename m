Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20151109085135.GP19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
	<1446319284-24778-8-git-send-email-kerolasa@iki.fi>
	<20151109085135.GP19508@ws.net.home>
Date: Sun, 22 Nov 2015 21:27:32 +0000
Message-ID: <CAG27Bk1aHHACHDwzF1s3taCzyCsw3T-oMEq8U_A7M6FY_pCHhQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] include/blkdev: add open_blkdev_or_file() function
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 9 November 2015 at 08:51, Karel Zak <kzak@redhat.com> wrote:
>  Hmmm... this abstraction introduces extra stat() calls. Would be
>  enough to use is_same_inode() directly in the code to reuse struct
>  stat?

I agree, previous version of open_blkdev_or_file() did too many stat()
calls. Reconsidered version takes stat structure as pointer. I found
all occurrences where this function was needed having to do stat() any
away, so this seems like the best way.

https://github.com/kerolasa/lelux-utiliteetit/commit/8fe1e638fa81d88e1e405f6221c7a592284c9b23

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
