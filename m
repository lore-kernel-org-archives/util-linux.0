Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:42959 "EHLO
	homiemail-a60.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753601Ab2B0RT6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Feb 2012 12:19:58 -0500
Subject: RE: [PATCH v3 3/4] lslocks: new command
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0F0AFAD64D@MCHP058A.global-ad.net>
References: <1330357315.2540.5.camel@offbook>
	 <7856072A9D04C24B82DFE2B1112FE38A0F0AFAD64D@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 27 Feb 2012 18:19:55 +0100
Message-ID: <1330363195.2540.6.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 2012-02-27 at 18:16 +0100, Voelker, Bernhard wrote:
> Davidlohr Bueso wrote:
> 
> 
> > +static char *get_cmdname(pid_t pid)
> > +{
> > +	FILE *fp;
> > +	char path[PATH_MAX];
> > +
> > +	sprintf(path, "/proc/%d/comm", pid);
> > +	if (!(fp = fopen(path, "r")))
> > +		return NULL;
> > +
> > +	/* just need the first line */
> > +	if (!fgets(path, sizeof(path), fp))
> > +		goto out;
> > +out:
> 
> this looks strange to me:
> if fgets fails, then we want to ...
> 
> > +	fclose(fp);
> 
> ... but certainly not this:

yep, that's bogus. Will send a v4.

Thanks.

> 
> > +	path[strlen(path) - 1] = '\0';
> > +	return xstrdup(path);
> > +}
> 
> Have a nice day,
> Berny
> 


