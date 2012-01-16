Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48295 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889Ab2APVMi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jan 2012 16:12:38 -0500
Date: Mon, 16 Jan 2012 22:12:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] fdisk: fix last sector dialog bug after an incorrect
 input with suffix
Message-ID: <20120116211235.GB29810@x2.net.home>
References: <1326692173-11791-1-git-send-email-cosoleto@gmail.com>
 <1326692173-11791-2-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326692173-11791-2-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 16, 2012 at 06:36:13AM +0100, Francesco Cosoleto wrote:
> If user input in a last sector dialog was out of range and with suffix, and if
> this was followed by accepting the default value, then the used last sector was
> erroneously default - 1.
> 
> Reported-by: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
> Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>

 Applied. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
