export interface FCMMultipleProjectPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
