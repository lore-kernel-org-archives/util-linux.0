Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56017 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756094AbaJXLgf (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 07:36:35 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6967120859
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 07:36:34 -0400 (EDT)
Message-Id: <1414150594.840980.182834749.2B446A18@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <5449BED0.9020103@gmx.com>
References: <5449BED0.9020103@gmx.com>
Subject: Re: [PATCH 3/5] hwclock: add message line breaks
Date: Fri, 24 Oct 2014 13:36:34 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 24, 2014, at 04:52, JWP wrote:
>  		if (rc < 1) {
>  			warnx(_("The date command issued by %s returned "
> -				"something other than an integer where the "
> +				"something other\nthan an integer where the "
>  				"converted time value was expected\n"
>  				"The command was:\n  %s\n"
>  				"The response was:\n %s\n"),

Oof.  This is real ugly -- a /n in the middle of a text line.

Benno

-- 
http://www.fastmail.fm - Access all of your messages and folders
                          wherever you are

