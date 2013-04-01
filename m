Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:43329 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758837Ab3DAQFG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Apr 2013 12:05:06 -0400
Received: by mail-wi0-f179.google.com with SMTP id hn17so1673748wib.0
        for <util-linux@vger.kernel.org>; Mon, 01 Apr 2013 09:05:04 -0700 (PDT)
Date: Mon, 1 Apr 2013 17:05:00 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/10] bash-completion: login-utils
Message-ID: <20130401160453.GC20549@gmail.com>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-5-git-send-email-kerolasa@iki.fi>
 <20130328014223.GX526@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130328014223.GX526@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 09:42:23PM -0400, Dave Reisner wrote:
> On Wed, Mar 27, 2013 at 10:07:46PM +0000, Sami Kerola wrote:
> > +++ b/shell-completion/chfn
> > @@ -0,0 +1,31 @@
> > +_chfn_module()
> > +{
> > +	local cur prev OPTS
> > +	COMPREPLY=()
> > +	cur="${COMP_WORDS[COMP_CWORD]}"
> > +	prev="${COMP_WORDS[COMP_CWORD-1]}"
> > +	case $prev in
> > +		'-f'|'--full-name')
> > +			COMPREPLY=( $(compgen -W "name" -- $cur) )
> > +			return 0
> > +			;;
> > +		'-o'|'--office')
> > +			COMPREPLY=( $(compgen -W "office" -- $cur) )
> > +			return 0
> > +			;;
> > +		'-p'|'--office-phone'|'-h'|'--home-phone')
> > +			COMPREPLY=( $(compgen -W "phone-nr" -- $cur) )
> > +			return 0
> > +			;;
> 
> I don't understand these. Given the previous argument being one of the
> found flags, you're completing staticly defined strings. Why complete
> anything at all?

I thought giving a textual hint to user is good idea.  The hint is now
gone.  Some of the commands are giving similar hints, other are not.  Let
see what is found to be more preferred by users and adjust accordingly.

> > +			OPTS="	-u --user
> > +				-m -p --preserve-environment
> > +				-g --group
> > +				-G --supp-group
> > +				- -l --login
> > +				-c --command
> > +				- -c
> > +				--session-command
> > +				-- -c
> 
> Please don't include the end of options marker in here. You appear to
> have duplicated -c as well.

Good catch, end of options marker is removed.  While writing this reply I
realized that the duplicates are still in my git.  Hold on I'll do rebase
fix to that.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
