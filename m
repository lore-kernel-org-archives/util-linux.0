Return-Path: elseifthen@gmx.com
Subject: Re: versioning
To: Karel Zak <kzak@redhat.com>
References: <20170517210953.dskdxcr3rdmbtvgs@ws.net.home>
 <CAG27Bk17xasjeZQP6YpzUvchZJ5mtG2K4w0dirRybxu98-pAcQ@mail.gmail.com>
 <20170518103640.3dedmk7lat74biev@ws.net.home>
 <24e52021-2e94-68a7-bd8c-51362af1d749@gmx.com>
 <20170518195648.gxhsd4zak57wfcg3@ws.net.home>
 <2d5ad507-f51c-7b1b-3aa3-355609cb609c@gmx.de>
 <dfa49f1d-e310-667a-20d3-897bbff2ea83@gmx.com>
 <20170520193446.bt44te35kji2gmzo@ws.net.home>
 <b6e7901f-4df8-6842-0475-0290d110f68e@gmx.com>
 <20170523075733.wwlzrff6atybmsal@ws.net.home>
 <20170523080513.3yhhfzlmnyqoovpd@ws.net.home>
 <614d0e03-6baf-861b-8636-71c07443b3b6@gmx.com>
Cc: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>,
 util-linux <util-linux@vger.kernel.org>
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <671ded97-cdf5-6f01-393d-a96372382f13@gmx.com>
Date: Sat, 27 May 2017 14:55:41 -0400
MIME-Version: 1.0
In-Reply-To: <614d0e03-6baf-861b-8636-71c07443b3b6@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 05/23/2017 04:54 PM, J William Piggott wrote:
> 
> I think I will submit a patch to add something to Documentation about
> this so that someone else might not ask the same dumb questions.

I started on this and noticed that the source-code-management.txt and
README files are very similar. README actually has a more complete
version schema breakdown. Is there any reason that they should not be
combined into a single file?

I think maintaining a single file for links, contacts, repo locations,
etc. makes things easier. There are only three files referencing
source-code-management.txt, one of them is README. Seems okay to have
the other two files point at the README file instead?

README includes the mailing list. Is there any reason that the IRC
channel shouldn't be there instead of in howto-contribute.txt?

The howto-contribute.txt file says patches can be sent to the mailing
list or directly to Karel, and points to README for the addresses. Is
there any reason not to have Karel's email contact in the README?


> 
> Sorry for wasting your time Karel (and anyone else reading this). Thank
> you for setting me straight.
> 
> 
>>
>>     Karel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
