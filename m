Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26876 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767Ab3AGLvO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Jan 2013 06:51:14 -0500
Date: Mon, 7 Jan 2013 12:51:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Miloslav Trmac <mitr@redhat.com>
Cc: Cody Maloney <cmaloney@theoreticalchaos.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] chsh: Add libuser support
Message-ID: <20130107115103.GD28963@x2.redhat.com>
References: <1357183321-24637-4-git-send-email-cmaloney@theoreticalchaos.com>
 <805019865.52854570.1357230851238.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <805019865.52854570.1357230851238.JavaMail.root@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 03, 2013 at 11:34:11AM -0500, Miloslav Trmac wrote:
> > +	memset(&val, 0, sizeof(val));
> > +	g_value_init(&val, G_TYPE_STRING);
> > +	g_value_set_string(&val, shell);
> > +
> > +	lu_ent_clear(ent, LU_LOGINSHELL);
> > +	lu_ent_add(ent, LU_LOGINSHELL, &val);
> If you don't mind depending on libuser >= 0.58, all of the above can be replaced with
> > lu_ent_set_string(ent, LU_LOGINSHELL, shell);
> and you can drop the "g_value_unset" calls as well.

 It would be nice to drop g_* junk :-)
 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
