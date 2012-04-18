Return-Path: P@draigBrady.com
Message-ID: <4F8E9B95.5010303@draigBrady.com>
Date: Wed, 18 Apr 2012 11:46:45 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>
CC: Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Davidlohr Bueso <dave@gnu.org>
Subject: Re: [PATCH 5/8] sfdisk: fix silly mbyte typo
References: <4F8D2D12.8070206@bernhard-voelker.de> <4F8D76AB.2090806@draigBrady.com> <4F8D7AB3.1010406@bernhard-voelker.de> <4F8D7EEF.8060601@draigBrady.com> <20120417144801.GA2391@x2.net.home> <4F8D8562.2020805@bernhard-voelker.de> <4F8E6429.2030408@bernhard-voelker.de>
In-Reply-To: <4F8E6429.2030408@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 04/18/2012 07:50 AM, Bernhard Voelker wrote:
> 
> 
> On 04/17/2012 04:59 PM, Bernhard Voelker wrote:
>>
>>
>> On 04/17/2012 04:48 PM, Karel Zak wrote:
>>>  yep, my +1 was about s/mebibytes/MiB/, I have overlooked the
>>>  1024*1024 math in the patch. Pádraig is right, (s)fdisk uses 1024
>>>  byte blocks in output 
>>
>> so KiB would be right?
>>
>>>  (probably too keep things more confusing ;-)
>>
>> mission accomplished ...
>>
>> Bye,
>> Berny
>>
> 
> ah, that part refers to the "#blocks" column!
> 
> The problem starts with the "=" after "Units". A colon would
> maybe be more appropriate: then we could use the equal sign
> like in the following.
> 
> What do you think?
> 
> Have a nice day,
> Berny
> 
> 
>>From 1c59d9ca4d18d795de354003d0059dc593c6a99b Mon Sep 17 00:00:00 2001
> From: Bernhard Voelker <mail@bernhard-voelker.de>
> Date: Wed, 18 Apr 2012 08:47:29 +0200
> Subject: [PATCH] sfdisk (out_partition_header): improve F_MEGABYTE header
> 
> Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
> ---
>  fdisk/sfdisk.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
> index 95e5828..c14d127 100644
> --- a/fdisk/sfdisk.c
> +++ b/fdisk/sfdisk.c
> @@ -912,24 +912,24 @@ out_partition_header(char *dev, int format, struct geometry G) {
>  		G.cylindersize ? _("cylinders") : _("sectors"));
>      case F_CYLINDER:
>  	if (G.cylindersize) {
> -	    printf(_("Units = cylinders of %lu bytes, blocks of 1024 bytes"
> +	    printf(_("Units: cylinders of %lu bytes, blocks of 1024 bytes"
>  		     ", counting from %d\n\n"), G.cylindersize << 9, increment);
>  	    printf(_("   Device Boot Start     End   #cyls    #blocks   Id  System\n"));
>  	    break;
>  	}
>  	/* fall through */
>      case F_SECTOR:
> -	printf(_("Units = sectors of 512 bytes, counting from %d\n\n"),
> +	printf(_("Units: sectors of 512 bytes, counting from %d\n\n"),
>  	       increment);
>  	printf(_("   Device Boot    Start       End   #sectors  Id  System\n"));
>  	break;
>      case F_BLOCK:
> -	printf(_("Units = blocks of 1024 bytes, counting from %d\n\n"),
> +	printf(_("Units: blocks of 1024 bytes, counting from %d\n\n"),
>  	       increment);
>  	printf(_("   Device Boot   Start       End    #blocks   Id  System\n"));
>  	break;
>      case F_MEGABYTE:
> -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
> +	printf(_("Units: 1MiB = 1024*1024 bytes, blocks of 1024 bytes"
>  		 ", counting from %d\n\n"), increment);
>  	printf(_("   Device Boot Start   End    MiB    #blocks   Id  System\n"));
>  	break;

+1
