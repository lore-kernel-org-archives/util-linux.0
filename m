Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20951 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbaBUMoZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Feb 2014 07:44:25 -0500
Date: Fri, 21 Feb 2014 13:44:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Jesper Dahl Nyerup <nyerup@one.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] script: Also flush writes to timing file.
Message-ID: <20140221124420.GE30903@x2.net.home>
References: <1392673386-42128-1-git-send-email-nyerup@one.com>
 <1392752925-48502-1-git-send-email-nyerup@one.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392752925-48502-1-git-send-email-nyerup@one.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 18, 2014 at 08:48:45PM +0100, Jesper Dahl Nyerup wrote:
>  term-utils/script.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

 Applied, thanks.

 I have also made the files usage more robust and close all in done()
 (based on Sami's suggestion).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
