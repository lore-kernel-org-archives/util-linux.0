Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33737 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbbAFK5E (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Jan 2015 05:57:04 -0500
Date: Tue, 6 Jan 2015 11:57:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 02/10] ipcs: in usage show resource option as nonoptional
 when used with -i
Message-ID: <20150106105700.GD18528@x2.net.home>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
 <1419440170-10850-2-git-send-email-bensberg@justemail.net>
 <1419847798.2518197.207547701.6852BB36@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419847798.2518197.207547701.6852BB36@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 29, 2014 at 11:09:58AM +0100, Benno Schulenberg wrote:
> 
> On Wed, Dec 24, 2014, at 17:56, Benno Schulenberg wrote:
> >  	fprintf(out, USAGE_HEADER);
> > -	fprintf(out, " %s [resource ...] [output-format]\n", program_invocation_short_name);
> > -	fprintf(out, " %s [resource] -i <id>\n", program_invocation_short_name);
> > +	fprintf(out, _(" %1$s [resource-option...] [output-option]\n"
> > +		       " %1$s -m|-q|-s -i <id>\n"), program_invocation_short_name);
> >  	fprintf(out, USAGE_OPTIONS);
> 
> Ow...  Most of these patching will need rebasing when the docstring
> patch has been applied.  Have done that locally and will resubmit.

 Unnecessary, I did it locally and merged an pushed all.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
