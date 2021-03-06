/*
 * Copyright (c) 2013 Mattes Groeger
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "ViewController.h"
#import "MGBenchmark.h"
#import "MGBenchmarkSession.h"
#import "MGConsoleOutput.h"
#import "MGConsoleSummaryOutput.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self standardOutput];
	[self customizedOutput];
	[self summaryOutput];
}

- (void)standardOutput
{
	NSLog(@"### DEFAULT OUTPUT ###");

	[self startBenchmark];
}

- (void)customizedOutput
{
	NSLog(@"### CUSTOMIZED OUTPUT ###");

	MGConsoleOutput *output = [[MGConsoleOutput alloc] init];
	output.timeMultiplier = 1000; // to get ms rather than seconds
	output.timeFormat = @"%.3fms"; // with 3 digits after comma
	output.stepFormat = @"${stepName}: ${passedTime}";
	output.totalFormat = @"total: ${passedTime}";

	[MGBenchmark setDefaultTarget:output];

	[self startBenchmark];
}

- (void)summaryOutput
{
	NSLog(@"### CUSTOMIZED SUMMARY OUTPUT ###");

	MGConsoleSummaryOutput *output = [[MGConsoleSummaryOutput alloc] init];
	output.timeMultiplier = 1000; // to get ms rather than seconds
	output.timeFormat = @"%.3fms"; // with 3 digits after comma
	output.totalFormat = @"total: ${passedTime}";
	output.summaryFormat = @"${stepTime} (${stepPercent}%) ${stepName}";

	[MGBenchmark setDefaultTarget:output];

	[self startBenchmark];
}

- (void)startBenchmark
{
	[MGBenchmark start:@"demo"];

	[[MGBenchmark session:@"demo"] step:@"step1"];
	[[MGBenchmark session:@"demo"] step:@"step2"];
	[[MGBenchmark session:@"demo"] step:@"step3"];

	[[MGBenchmark session:@"demo"] total];

	[MGBenchmark finish:@"demo"];
}

@end
