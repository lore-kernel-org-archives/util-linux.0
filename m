Return-Path: util-linux-owner@vger.kernel.org
Received: from mail1.vodafone.ie ([213.233.128.43]:55201 "EHLO
	mail1.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbaFZKwN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 26 Jun 2014 06:52:13 -0400
Message-ID: <53ABFB5A.9020005@draigBrady.com>
Date: Thu, 26 Jun 2014 11:52:10 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Bernhard Voelker <mail@bernhard-voelker.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: fallocate: --punch option parsing error diagnostics irritating
References: <53AB2E36.5060405@bernhard-voelker.de> <20140626101009.GD30418@x2.net.home>
In-Reply-To: <20140626101009.GD30418@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/26/2014 11:10 AM, Karel Zak wrote:
> On Wed, Jun 25, 2014 at 10:16:54PM +0200, Bernhard Voelker wrote:
>>   $ ./fallocate -p -l 10000 /tmp/x
>>   fallocate: only -n mode can be used with --zero-range
>>
>> Huh? I didn't specify neither -n nor -z.
> 
> 		case 'p':
> 			mode |= FALLOC_FL_PUNCH_HOLE;
> 			/* fall through */
> 		case 'n':
> 			mode |= FALLOC_FL_KEEP_SIZE;
> 			break;
> 
> 
> unfortunately there is nothing about it in man page and usage(). It's
> described in fallocate(2) syscall man page only.
> 
> Anyway, the code is wrong, it assumes that KEEP_SIZE is possible to use
> only with ZERO_RANGE. 
> 
> Fixed in git tree, man page massively modified to be readable for
> humans (original text in the man page was from FS devels:-)
> 
>> Finally, please add some examples to the man page.
> 
> I think the new version of the man page is good enough without examples, but 
> if someone has something nice we can add EXAMPLES section.

--help could he clarified:

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index d950f9c..6192f0a 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -75,13 +75,13 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
        fprintf(out,
              _(" %s [options] <filename>\n"), program_invocation_short_name);
        fputs(USAGE_OPTIONS, out);
-       fputs(_(" -c, --collapse-range collapse space in the file\n"), out);
-       fputs(_(" -d, --dig-holes      detect and dig holes\n"), out);
-       fputs(_(" -l, --length <num>   length of the (de)allocation, in bytes\n"), out);
-       fputs(_(" -n, --keep-size      don't modify the length of the file\n"), out);
-       fputs(_(" -o, --offset <num>   offset of the (de)allocation, in bytes\n"), out);
-       fputs(_(" -p, --punch-hole     punch holes in the file (implies --keep-size)\n"), out);
-       fputs(_(" -z, --zero-range     zeroes a range in the file\n"), out);
+       fputs(_(" -c, --collapse-range remove a range from the file\n"), out);
+       fputs(_(" -d, --dig-holes      detect zeroes and replace with holes\n"), out);
+       fputs(_(" -l, --length <num>   length for range operations, in bytes\n"), out);
+       fputs(_(" -n, --keep-size      maintain the apparent size of the file\n"), out);
+       fputs(_(" -o, --offset <num>   offset for range operations, in bytes\n"), out);
+       fputs(_(" -p, --punch-hole     replace a range with a hole (implies -n)\n"), out);
+       fputs(_(" -z, --zero-range     zero and ensure allocation of a range\n"), out);
        fputs(_(" -v, --verbose        verbose mode\n"), out);

        fputs(USAGE_SEPARATOR, out);

