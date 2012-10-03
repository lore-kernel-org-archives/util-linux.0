Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18258 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865Ab2JCKYF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Oct 2012 06:24:05 -0400
Date: Wed, 3 Oct 2012 12:24:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Cody Maloney <cmaloney@theoreticalchaos.com>
Cc: util-linux@vger.kernel.org, Miloslav Trmac <mitr@redhat.com>
Subject: Re: Adding support to chsh for non-local shell modification
Message-ID: <20121003102401.GA2149@x2.net.home>
References: <CA+K3q6r_QfCWmCBMEiytKCQG8j-4P92sWxO-ZNz_ALWpr=2knA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+K3q6r_QfCWmCBMEiytKCQG8j-4P92sWxO-ZNz_ALWpr=2knA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 02, 2012 at 07:58:39PM -0700, Cody Maloney wrote:
> I would like to implement support for non-local shell changing in chsh
> at the very least, and possibly support for non-local user attributes
> in general for the other attribute modification tools in login-utils.
> For my purposes I need LDAP support, but it would probably be better
> to make it able to use an arbitrary storage backend.  Ideally an API
> would already exist for this, but while one for setting authentication
> tokens has evolved (pam_chauthtok) and one for reading user attributes
> (Name Service Switch NSS), but none for setting them as far as I can
> tell. As such, I think the best route would be just to make a new API
> for this.

 Already implemented:
     https://fedorahosted.org/libuser/

 it also provides utils like lchfn or lchsh. Not sure, but maybe it
 would be possible to optionally link the default chfn and chsh utils
 with the library too.

 [CC: to Miroslav, author of the library]

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
