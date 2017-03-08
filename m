Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:64773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751460AbdCHRPT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 8 Mar 2017 12:15:19 -0500
Subject: Re: [PATCH 07/13] blkid: define output names only once
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170305205232.24030-1-kerolasa@iki.fi>
 <20170305205232.24030-8-kerolasa@iki.fi>
 <c0779c68-d9cf-0eb0-f8e4-91130ee57db9@gmx.com>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1998d830-63b1-a477-d5ae-4219171c0b3c@gmx.com>
Date: Wed, 8 Mar 2017 12:14:29 -0500
MIME-Version: 1.0
In-Reply-To: <c0779c68-d9cf-0eb0-f8e4-91130ee57db9@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 03/07/2017 09:37 AM, J William Piggott wrote:
> 
> 
> On 03/05/2017 03:52 PM, Sami Kerola wrote:
> 
>> +				warnx(_("Invalid output format %s. "
>> +					"Choose from value:"), optarg);
>> +				fputc('\t', stderr);
>> +				for (j = 0; j < ARRAY_SIZE(output_names); j++)
>> +					fprintf(stderr, "%s%s", j == 0 ? "" : " ", output_names[j]);
>> +				fputc('\n', stderr);
>> +				exit(BLKID_EXIT_OTHER);
> 
> 
> I see, it is saying "Choose a value from:". 'Choose from:" is enough,
> it's confusing to use 'value' when it is also one of the choices.
> 
> I also see, that 2 of the output choices are deprecated. If they are
> going to be excluded from the 'help' output, shouldn't they be excluded
> from the error messages as well?

After replying yesterday something else occurred to me. This seems
unnecessarily complex for an error message. Isn't "Invalid output format %s. "
enough? Then let them either use --help or RTM?

It shouldn't be capitalized and the invalid value should be quoted:
warnx(_("invalid output format '%s'"



