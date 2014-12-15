Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbaLOKHr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Dec 2014 05:07:47 -0500
Date: Mon, 15 Dec 2014 11:07:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 15/16] chfn: move new and old finger structs to chfn
 control struct
Message-ID: <20141215100735.GZ19904@x2.net.home>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
 <1418579052-29386-16-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418579052-29386-16-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 14, 2014 at 05:44:11PM +0000, Sami Kerola wrote:
> +	ctl->newf.full_name = prompt(_("Name"), ctl->oldf.full_name);
> +	ctl->newf.office = prompt(_("Office"), ctl->oldf.office);
> +	ctl->newf.office_phone = prompt(_("Office Phone"), ctl->oldf.office_phone);
> +	ctl->newf.home_phone = prompt(_("Home Phone"), ctl->oldf.home_phone);

it would be better to rename prompt() to ask_new_field() or so.

> -static int set_changed_data(struct finfo *oldfp, struct finfo *newfp)
> +static int set_changed_data(struct chfn_control *ctl)
>  {
>  	int changed = false;
>  
> -	if (newfp->full_name) {
> -		oldfp->full_name = newfp->full_name;
> +	if (ctl->newf.full_name)
>  		changed = true;
> -	}
> -	if (newfp->office) {
> -		oldfp->office = newfp->office;
> +	else
> +		ctl->newf.full_name = ctl->oldf.full_name;
> +	if (ctl->newf.office)
>  		changed = true;
> -	}
> -	if (newfp->office_phone) {
> -		oldfp->office_phone = newfp->office_phone;
> +	else
> +		ctl->newf.office = ctl->oldf.office;
> +	if (ctl->newf.office_phone)
>  		changed = true;
> -	}
> -	if (newfp->home_phone) {
> -		oldfp->home_phone = newfp->home_phone;
> +	else
> +		ctl->newf.office_phone = ctl->oldf.office_phone;
> +	if (ctl->newf.home_phone)
>  		changed = true;
> -	}
> -
> +	else
> +		ctl->newf.home_phone = ctl->oldf.home_phone;
>  	return changed;
>  }

this is ugly and unnecessary function, all you need is to return
usable data from prompt() and maintain ctl->changed with in the
function. The prompt() knows all the detains.

>  	/* create the new gecos string */
> -	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", pinfo->full_name, pinfo->office,
> -		  pinfo->office_phone, pinfo->home_phone, pinfo->other);
> +	len = xasprintf(&gecos, "%s,%s,%s,%s,%s", ctl->newf.full_name, ctl->newf.office,
> +		  ctl->newf.office_phone, ctl->newf.home_phone, ctl->newf.other);

Maybe

  len = xasprintf(&gecos, "%s,%s,%s,%s,%s", 
        ctl->newf.full_name ? ctl->newf.full_name : "",
        ...
        );

would be better than set the empty strings to newf (now you mix ""
and strdup() results in newf).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
