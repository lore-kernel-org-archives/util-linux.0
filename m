Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbdCMOhT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 10:37:19 -0400
Date: Mon, 13 Mar 2017 15:37:14 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 06/13] blkid: add messages to translations
Message-ID: <20170313143714.6e35m66huz7ciwsm@ws.net.home>
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-7-kerolasa@iki.fi>
 <83d6c687-8fec-0446-0914-ff00eb3837fc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83d6c687-8fec-0446-0914-ff00eb3837fc@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 07, 2017 at 09:15:25AM -0500, J William Piggott wrote:
> 
> 
> On 03/05/2017 03:52 PM, Sami Kerola wrote:
> 
>  8< ---
> 
> > +	fputs(_(	" -o <format> output format; can be one of:\n"
> > +			"               value, device, export or full; (default: full)\n"), out);
> 
> 	This says there are four output formats, but the error message
> 	below lists six?
> 
>  8< ---
> 
> > @@ -721,39 +724,38 @@ int main(int argc, char **argv)
> >  			else if (!strcmp(optarg, "full"))
> >  				output_format = 0;
> >  			else {
> > -				fprintf(stderr, "Invalid output format %s. "
> > +				errx(BLKID_EXIT_OTHER, _("Invalid output format %s. "
> >  					"Choose from value,\n\t"
> > -					"device, list, udev or full\n", optarg);
> > -				exit(BLKID_EXIT_OTHER);
> > +					"value, device, list, udev, export, or full"), optarg);
> 
> 
>  8< ---
> 
> 
> Looks like the above outputs 'value' twice?
> 
> Maybe it should also have a colon "Choose from:\n\t"
> 
> A single line would be preferable I think:
> "Choose from: value, device, list, udev, export, or full"

 The message is unnecessary complex, the list of the supported
 arguments is overkill. I have merged:

    errx(BLKID_EXIT_OTHER, _("unsupported output format %s"), optarg);

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
