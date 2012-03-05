Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756980Ab2CEMiu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Mar 2012 07:38:50 -0500
Date: Mon, 5 Mar 2012 13:38:47 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] fixes to todo items etc
Message-ID: <20120305123847.GD486@x2.net.home>
References: <CAG27Bk1Lm57u2wX0LQFWhvo8kanpOF6YSt_UgsSuuOcfB1LxPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1Lm57u2wX0LQFWhvo8kanpOF6YSt_UgsSuuOcfB1LxPg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Sami,

On Sun, Mar 04, 2012 at 02:35:05PM +0100, Sami Kerola wrote:
> Sami Kerola (17):
>       docs: add deprecation comments
>       docs: TODO removal, login-utils error printing
>       sfdisk: use rpmatch to yes/no question
>       mesg: use rpmatch to yes/no question
>       vipw: use rpmatch to yes/no question
>       docs: TODO removal, rpmatch task is done
>       chfn: use pathnames.h for paths
>       chsh: use pathnames.h for paths

 if you already have file descriptor then use the descriptor for
 fchmod/fchown rather than chmod by filenames.

>       lib: add fileutils function collection
>       wall: use xmkstemp for temporary file
>       setpwnam: use xmkstemp() and lckpwdf()
>       vipw: use xmkstemp() and lckpwdf()

 Please, send all security sensitive changes (and xmkstemp() code)
 to our mailing list for review.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
