Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbdCMMxS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 08:53:18 -0400
Date: Mon, 13 Mar 2017 13:53:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 07/13] blkid: define output names only once
Message-ID: <20170313125308.pncef56i65tcc3ut@ws.net.home>
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-8-kerolasa@iki.fi>
 <c0779c68-d9cf-0eb0-f8e4-91130ee57db9@gmx.com>
 <1998d830-63b1-a477-d5ae-4219171c0b3c@gmx.com>
 <alpine.LNX.2.20.1703100917380.28674@imuri>
 <alpine.LNX.2.20.1703101434490.19808@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1703101434490.19808@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 10, 2017 at 02:48:24PM +0000, Sami Kerola wrote:
> Having day off and idea to generalize this did not go away from my mind, 
> so I decided to give it a shot. I'm not sure how many utils might need 

 The problem I see is that you force code writers to use your
 option_argument although the option argument may be part of the
 bigger picture. This is reason why for example string_to_idarray()
 string_to_bitarray() parses use name2id() callback.

 Anyway, we have probably more places where a simple string to id
 conversion is used. My recommendation is to add to lib/strutils.c
 string_to_idx() and use array of strings and return array index:

static int string_to_idx(const char **ary, size_t n, const char *name)
{
	size_t i;

	for (i = 0; i < n; i++) {
		if (strcmp(ary[i], name) == 0)
			return i;
	}
	return -1;
}

 such function you can use on many many places, not only for options
 arguments parsing.

> +static inline int parse_arg_name(const struct option_arguments *valid_args,
> +				 const char *arg)
> +{
> +	size_t i;
> +
> +	for (i = 0; valid_args[i].name; i++) {
> +		if (strcmp(valid_args[i].name, arg) != 0)
> +			continue;
> +		switch (valid_args[i].status) {
> +		case arg_in_use:
> +		case arg_hide:
> +			return valid_args[i].id;
> +		case arg_deprecate:
> +			warnx(_("'%s' is deprecated"), arg);
> +			return valid_args[i].id;

 The warning is unacceptable. Let's imagine you use old udev and you
 call blkid in your udev rules...

 It's always better to minimize number of messages for tools executed
 from scripts.

 All the valid_args->status seems like over-engineering ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
