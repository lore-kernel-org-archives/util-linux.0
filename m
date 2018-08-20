Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTMBh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 20 Aug 2018 08:01:37 -0400
Date: Mon, 20 Aug 2018 10:46:50 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <asbjorn@asbjorn.st>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] script: add input log feature
Message-ID: <20180820084650.xpit6acizkqt56qs@ws.net.home>
References: <20180819171658.20285-1-asbjorn@asbjorn.st>
 <20180819171658.20285-2-asbjorn@asbjorn.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180819171658.20285-2-asbjorn@asbjorn.st>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 19, 2018 at 05:16:58PM +0000, Asbjørn Sloth Tønnesen wrote:
> When script is used to log usage of shell accounts, accessible by
> random users (some of whom might be malicious).
> 
> This patch adds a new --input-log option, which makes script save
> the input data to a file, in an extended timing format also containing
> the data, thereby allowing the input to be reconstructed.

I like the feature, but not sure if we really need to introduce a new
log format specific to the input stream.

For long time I think about a new timing file format. Maybe we can add
support for new timing file format where will be possible log
information about more streams (stdin and stdout) and events (for
example signals). In this case we can for stdin use the same concept
like for stdout -- it means raw file with data. The final result will
be three files:

 - stdout (raw, without formatting)
 - stdin  (raw, without formatting)
 - timing (<type> <timestampts> [<offset> , misc...])

where 
  type         = S, I or O  (signal, input or output)
  timestampts  = timing info
 
  type specific information:
     offset = offset in bytes to the log (stream) file (O or I  type)
     signal = signal name for S type
     ..etc.

It would be also nice to have info about version, format in the
timing file header.

And new options like:

   --timing-format <classic,new>
   --recording <stdin,stdout,signals,...>
   --stdout-log <filename>
   --stdin-log <filename>

The default should be backwardly compatible (old format, stdout-only, etc.)

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
