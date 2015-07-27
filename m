Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbbG0LVO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jul 2015 07:21:14 -0400
Date: Mon, 27 Jul 2015 13:21:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] cfdisk: keep the extra info block separate from menu
 and partitions
Message-ID: <20150727112112.GE6865@ws.net.home>
References: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
 <1437837498-23833-4-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437837498-23833-4-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 25, 2015 at 05:18:17PM +0200, Benno Schulenberg wrote:
> -	if ((size_t) win_ex_start_line + win_height + 1 < MENU_START_LINE)
> -		win_ex_start_line = MENU_START_LINE - win_height;
> -
>  	win_ex = subwin(stdscr, win_height, ui_cols - 2, win_ex_start_line, 1);

 I have made small survey between colleagues in the office and result is "down".

    http://people.redhat.com/kzak/cfdisk-down.png
    http://people.redhat.com/kzak/cfdisk-up.png

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
