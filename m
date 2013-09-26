Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab3IZHuC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Sep 2013 03:50:02 -0400
Date: Thu, 26 Sep 2013 09:49:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Namhyung Kim <namhyung@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] libmount: Get rid of an unnecessary check
Message-ID: <20130926074958.GB5101@x2.net.home>
References: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 26, 2013 at 12:32:03AM +0900, Namhyung Kim wrote:
>  libmount/src/init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks. (The same code we had in libblkid, fixed too.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
