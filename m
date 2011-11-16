Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:47117 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752839Ab1KPMrl convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:47:41 -0500
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>, Bernhard Voelker <mail@bernhard-voelker.de>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Wed, 16 Nov 2011 13:47:39 +0100
Subject: RE: [PATCH 02/15] prlimit: add opt_id array to match short options
	to limit ids
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D86E24B44@MCHP058A.global-ad.net>
References: <4EC07354.8000803@bernhard-voelker.de>
 <20111116123633.GB7916@nb.net.home>
In-Reply-To: <20111116123633.GB7916@nb.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> On Mon, Nov 14, 2011 at 02:48:04AM +0100, Bernhard Voelker wrote:
> > +	static const size_t opt_id[] = {
> > +		['c'] = CORE,
> > +		['d'] = DATA,
> > +		['e'] = NICE,
> > +		['f'] = FSIZE,
> > +		['i'] = SIGPENDING,
> > +		['l'] = MEMLOCK,
> > +		['m'] = RSS,
> > +		['n'] = NOFILE,
> > +		['q'] = MSGQUEUE,
> > +		['r'] = RTPRIO,
> > +		['s'] = STACK,
> > +		['t'] = CPU,
> > +		['u'] = NPROC,
> > +		['v'] = AS,
> > +		['x'] = LOCKS,
> > +		['y'] = RTTIME
> > +		/* h = help, o = output columns, p = pid, V = version */
> > +	};
> 
>  Sorry, not applied. This change does not make the code more robust or
>  readable and does not fix any error.

Later on in [PATCH 11/15], I needed do n++ in a separate statement in
each case (because lims[] is no longer filled as arguments can be parsed
but instead, there's one element per limit type.

@@ -573,7 +584,8 @@ int main(int argc, char **argv)
  		case 'v':
  		case 'x':
  		case 'y':
-				add_prlim(optarg, &lims[n++], opt_id[opt]);
+				add_prlim(optarg, &lims[opt_id[opt]], opt_id[opt]);
+				n++;
  				break;

This additional statement made the switch/case rather huge.

Berny